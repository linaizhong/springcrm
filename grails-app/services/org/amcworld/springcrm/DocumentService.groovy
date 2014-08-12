/*
 * DocumentService.groovy
 *
 * Copyright (c) 2011-2014, Daniel Ellermann
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

import org.apache.commons.vfs2.FileObject
import org.apache.commons.vfs2.FileSystemManager
import org.apache.commons.vfs2.NameScope
import org.apache.commons.vfs2.VFS
import org.codehaus.groovy.grails.commons.GrailsApplication


class DocumentService {

    //-- Class variables ------------------------

    static transactional = false


    //-- Instance variables ---------------------

    GrailsApplication grailsApplication


    //-- Public methods -------------------------

    /**
     * Gets the {@code FileObject} with the given path.  The method ensures
     * that only pathes below the root are used.
     *
     * @param path  the given path
     * @return      the file
     */
    FileObject getFile(String path) {
        root.resolveFile path, NameScope.DESCENDENT_OR_SELF
    }

    /**
     * Gets the {@code FileObject} representing the root of the document file
     * system.
     *
     * @return  the document root
     */
    FileObject getRoot() {
        VFS.manager.resolveFile rootPath
    }

    /**
     * Gets the path where to store the documents of this application.
     *
     * @return  the root path to store documents
     */
    String getRootPath() {
        grailsApplication.config.springcrm.dir.documents
    }

    /**
     * Uploads a file to the given folder using the given name.
     *
     * @param path      the path where to store the file
     * @param fileName  the name of the file to create
     * @param data      the file data to store
     */
    void uploadFile(String path, String fileName, InputStream data) {
        FileObject dir = getFile(path)
        FileObject f = dir.resolveFile(fileName, NameScope.DESCENDENT_OR_SELF)
        f.content.outputStream << data
        f.content.close()
    }
}
