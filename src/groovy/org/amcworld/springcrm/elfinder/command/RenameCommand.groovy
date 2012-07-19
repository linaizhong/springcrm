/*
 * RenameCommand.groovy
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


package org.amcworld.springcrm.elfinder.command

import org.amcworld.springcrm.elfinder.ConnectorThrowable;
import org.amcworld.springcrm.elfinder.ConnectorError as CE
import org.amcworld.springcrm.elfinder.ConnectorException
import org.amcworld.springcrm.elfinder.fs.Volume


/**
 * The class {@code RenameCommand} represents ...
 *
 * @author	Daniel Ellermann
 * @version 1.2
 * @since   1.2
 */
class RenameCommand extends Command {

    //-- Public methods -------------------------

    @Override
    public void execute() {
        if (target) {
            Volume volume = getVolume(target)
            if (!volume) {
                throw new ConnectorException(
                    CE.RENAME, targetHash, CE.FILE_NOT_FOUND
                )
            }
            Map<String, Object> rm = volume.file(target)
            if (rm == null) {
                throw new ConnectorException(
                    CE.RENAME, targetHash, CE.FILE_NOT_FOUND
                )
            }
            rm.realpath = volume.realPath(target)
            Map<String, Object> file
            try {
                file = volume.rename(target, getParam('name'))
            } catch (ConnectorThrowable ct) {
                throw new ConnectorException(CE.RENAME, rm.name, ct)
            }
            if (!file) {
                throw new ConnectorException(CE.RENAME, rm.name)
            }
            response['added'] = file
            response['removed'] = rm
        }
    }
}