/*
 * SeqNumber.groovy
 *
 * Copyright (c) 2011-2013, Daniel Ellermann
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


/**
 * The class {@code SeqNumber} represents a sequence number which is used to
 * number various content items.
 *
 * @author	Daniel Ellermann
 * @version 1.3
 */
class SeqNumber {

    //-- Class variables ------------------------

    static constraints = {
		controllerName(blank: false)
		prefix(maxSize: 5)
		suffix(maxSize: 5)
		startValue(min: 0)
		endValue(min: 0)
    }
    static mapping = {
        controllerName index: 'controller_name'
    }


    //-- Instance variables ---------------------

	String controllerName
	String prefix = ''
	String suffix = ''
	int startValue = 10000i
	int endValue = 99999i


    //-- Public methods -------------------------

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof SeqNumber) {
            return obj.controllerName == controllerName
        } else {
            return false
        }
    }

    @Override
    public int hashCode() {
        return controllerName.hashCode()
    }

    @Override
    String toString() {
        return controllerName
    }
}
