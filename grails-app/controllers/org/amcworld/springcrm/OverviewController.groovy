/*
 * OverviewController.groovy
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

import javax.servlet.http.HttpServletResponse
import org.springframework.context.i18n.LocaleContextHolder as LCH


/**
 * The class {@code OverviewController} contains actions which display the
 * overview page and handle the panels.
 *
 * @author	Daniel Ellermann
 * @version 1.3
 */
class OverviewController {

    //-- Instance variables ---------------------

  LruService lruService


    //-- Public methods -------------------------

    def index() {
        Map<Integer, List<Panel>> panels = new HashMap()
        for (int i = 0; i < Panel.NUM_COLUMNS; i++) {
            panels[i] = []
        }

        OverviewPanelRepository repository = OverviewPanelRepository.instance

        List<Panel> l = Panel.findAllByUser(session.user, [sort: 'col'])
        for (Panel panel : l) {
            panel.panelDef = repository.getPanel(panel.panelId)
            panels[panel.col][panel.pos] = panel
        }
        [panels: panels]
    }

    def listAvailablePanels() {
        OverviewPanelRepository repository = OverviewPanelRepository.instance
        def locale = LCH.locale
        render(contentType: 'text/json') {
            for (def entry in repository.panels) {
                setProperty(entry.key, {
                    def p = entry.value
                    title = p.getTitle(locale)
                    url = p.url
                    style = p.style
                })
            }
        }
    }

    def lruList() {
        def lruList = lruService.retrieveLruEntries()
        [lruList: lruList]
    }

    def addPanel(String panelId, Integer col, Integer pos) {

        /* move down all successors of the panel at new position */
        def c = Panel.createCriteria()
        def panels = c.list {
            eq('user', session.user)
            and {
                eq('col', col)
                ge('pos', pos)
            }
        }
        for (Panel p in panels) {
            p.pos++
            p.save flush: true
        }

        /* insert new panel */
        Panel panel = new Panel(
            user: session.user, col: col, pos: pos, panelId: panelId
        )
        panel.save flush: true
        render status: HttpServletResponse.SC_OK
    }

    def movePanel(String panelId, Integer col, Integer pos) {
        Panel panel = Panel.findByUserAndPanelId(session.user, panelId)
        if (panel) {

            /* move up all successors of the panel to move */
            def c = Panel.createCriteria()
            List<Panel> panels = c.list {
                eq('user', session.user)
                and {
                    eq('col', panel.col)
                    gt('pos', panel.pos)
                }
            }
            for (Panel p in panels) {
                p.pos--
                p.save flush: true
            }

            /* move down all successors of the panel at new position */
            c = Panel.createCriteria()
            panels = c.list {
                eq('user', session.user)
                and {
                    eq('col', col)
                    ge('pos', pos)
                }
            }
            for (Panel p in panels) {
                p.pos++
                p.save flush: true
            }

            /* save the panel */
            panel.col = col
            panel.pos = pos
            panel.save flush: true
        }
        render status: HttpServletResponse.SC_OK
    }

    def removePanel(String panelId) {
        Panel panel = Panel.findByUserAndPanelId(session.user, panelId)
        if (panel) {
            panel.delete flush: true

            def c = Panel.createCriteria()
            List<Panel> panels = c.list {
                eq('user', session.user)
                and {
                    eq('col', panel.col)
                    ge('pos', panel.pos)
                }
            }
            for (Panel p in panels) {
                p.pos--
                p.save flush: true
            }
        }
        render status: HttpServletResponse.SC_OK
    }
}
