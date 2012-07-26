/*
 * DocumentController.groovy
 *
 * Copyright (c) 2011-2012, Daniel Ellermann
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


package org.amcworld.springcrm

import groovy.io.FileType
import org.amcworld.springcrm.elfinder.Connector
import org.amcworld.springcrm.elfinder.ConnectorException
import org.amcworld.springcrm.elfinder.fs.LocalFileSystemVolume
import org.amcworld.springcrm.elfinder.fs.Volume
import org.amcworld.springcrm.elfinder.fs.VolumeConfig
import org.apache.commons.logging.LogFactory


/**
 * The class {@code DocumentController} handles actions which display documents
 * either in the ElFinder client or as embedded list for an organization.
 *
 * @author	Daniel Ellermann
 * @version 1.2
 * @since   1.2
 */
class DocumentController {

    //-- Constants ------------------------------

    private static final log = LogFactory.getLog(this)


    //-- Instance variables ---------------------

    def fileService


    //-- Public methods -------------------------

    def index() {}

    def command() {
        new Connector(request, response).
            addVolume(localVolume).
            process()
    }

    def listEmbedded() {
        def organizationInstance = Organization.get(params.organization)
        File dir = fileService.getOrgDocumentDir(organizationInstance)
        Volume volume = localVolume
        def list = []
        int total = 0
        if (dir) {
            List<Document> documents = []
            dir.eachFileRecurse(FileType.FILES) {
                documents << new Document(volume.encode(it.path), it)
            }

            String sort = params.sort
            String order = params.order
            documents.sort { f1, f2 ->
                def res
                if ('size' == sort) {
                    res = f1.size <=> f2.size
                } else if ('lastModified' == sort) {
                    res = f1.lastModified <=> f2.lastModified
                } else {
                    res = f1.name <=> f2.name
                }

                if ('desc' == order) {
                    res *= -1
                }
                return res
            }
            total = documents.size()

            def offset = params.offset ?: 0
            def max = params.max ?: 10
            list = documents.subList(offset, Math.min(offset + max, documents.size()))
        }

        return [documentInstanceList: list, documentInstanceTotal: total]
    }

    def download() {
        Volume volume = localVolume
        try {
            Map<String, Object> file = volume.file(params.id)
            if (file) {
                InputStream stream = volume.open(params.id)
                if (stream) {
                    response.contentType = file.mime
                    response.contentLength = file.size
                    response.addHeader 'Content-Disposition',
                        "attachment; filename=\"${file.name}\""
                    response.outputStream << stream
                    return null
                }
            }
        } catch (ConnectorException e) {
            log.error e
        }
        render(status: 404)
    }

    def delete() {
        try {
            if (localVolume.rm(params.id)) {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'document.label', default: 'Document')])
            }
        } catch (ConnectorException e) {
            log.error e
        }
        if (params.returnUrl) {
            redirect(url: params.returnUrl)
        } else {
            redirect(action: 'list')
        }
    }


    //-- Non-public methods ---------------------

    /**
     * Gets the local volume to retrieve and store documents.
     *
     * @return  the local volume
     */
    protected Volume getLocalVolume() {
        def sysConf = grailsApplication.config.springcrm
        def config = new VolumeConfig(
            alias: message(code: 'document.rootAlias', default: 'Documents'),
            useCache: sysConf.cacheDocs
        )
        return new LocalFileSystemVolume('l', sysConf.dir.documents, config)
    }
}
