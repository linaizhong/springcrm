/*
 * LinkModule.groovy
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


package org.amcworld.springcrm.module

import geb.Page


class LinkModule extends geb.Module {

    //-- Properties -----------------------------

    boolean isOpensNewWindow() {
        this.@target == '_blank'
    }


    //-- Public methods -------------------------

    void checkLinkToPage(Class<Page> page, Object... args) {
        String url = page.getAbsUrl(args)
        if (args) {
            assert url == this.@href
        } else {
            assert this.@href.startsWith(url)
        }
    }
}
