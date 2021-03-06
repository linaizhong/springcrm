/*
 * HelpdeskController.groovy
 *
 * Copyright (c) 2011-2015, Daniel Ellermann
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

import static javax.servlet.http.HttpServletResponse.SC_NOT_FOUND

import org.springframework.dao.DataIntegrityViolationException


class HelpdeskController {

    //-- Class variables ------------------------

    static allowedMethods = [save: 'POST', update: 'POST', delete: 'GET']


    //-- Instance variables ---------------------

    HelpdeskService helpdeskService
    MailSystemService mailSystemService


    //-- Public methods -------------------------

    def index() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        [
            helpdeskInstanceList: Helpdesk.list(params),
            helpdeskInstanceTotal: Helpdesk.count(),
            mailSystemConfigured: mailSystemService.configured
        ]
    }

    def create() {
        [helpdeskInstance: new Helpdesk(params)]
    }

    def copy(Long id) {
        Helpdesk helpdeskInstance = Helpdesk.get(id)
        if (!helpdeskInstance) {
            flash.message = message(
                code: 'default.not.found.message',
                args: [message(code: 'helpdesk.label'), id]
            )
            redirect action: 'index'
            return
        }

        helpdeskInstance = new Helpdesk(helpdeskInstance)
        render view: 'create', model: [helpdeskInstance: helpdeskInstance]
    }

    def save() {
        Helpdesk helpdeskInstance = new Helpdesk()
        if (!helpdeskService.saveHelpdesk(helpdeskInstance, params)) {
            render view: 'create', model: [helpdeskInstance: helpdeskInstance]
            return
        }

        request.helpdeskInstance = helpdeskInstance
        flash.message = message(
            code: 'default.created.message',
            args: [
                message(code: 'helpdesk.label'), helpdeskInstance.toString()
            ]
        )
        if (params.returnUrl) {
            redirect url: params.returnUrl
        } else {
            redirect action: 'show', id: helpdeskInstance.id
        }
    }

    def show(Long id) {
        Helpdesk helpdeskInstance = Helpdesk.get(id)
        if (!helpdeskInstance) {
            flash.message = message(
                code: 'default.not.found.message',
                args: [message(code: 'helpdesk.label'), id]
            )
            redirect action: 'index'
            return
        }

        [helpdeskInstance: helpdeskInstance]
    }

    def edit(Long id) {
        Helpdesk helpdeskInstance = Helpdesk.get(id)
        if (!helpdeskInstance) {
            flash.message = message(
                code: 'default.not.found.message',
                args: [message(code: 'helpdesk.label'), id]
            )
            redirect action: 'index'
            return
        }

        [helpdeskInstance: helpdeskInstance]
    }

    def update(Long id) {
        Helpdesk helpdeskInstance = Helpdesk.get(id)
        if (!helpdeskInstance) {
            flash.message = message(
                code: 'default.not.found.message',
                args: [message(code: 'helpdesk.label'), id]
            )
            redirect action: 'index'
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (helpdeskInstance.version > version) {
                helpdeskInstance.errors.rejectValue(
                    'version', 'default.optimistic.locking.failure',
                    [message(code: 'helpdesk.label')] as Object[],
                    'Another user has updated this Helpdesk while you were editing'
                )
                render view: 'edit', model: [helpdeskInstance: helpdeskInstance]
                return
            }
        }

        if (!helpdeskService.saveHelpdesk(helpdeskInstance, params)) {
            render view: 'edit', model: [helpdeskInstance: helpdeskInstance]
            return
        }

        request.helpdeskInstance = helpdeskInstance
        flash.message = message(
            code: 'default.updated.message',
            args: [
                message(code: 'helpdesk.label'), helpdeskInstance.toString()
            ]
        )

        if (params.returnUrl) {
            redirect url: params.returnUrl
        } else {
            redirect action: 'show', id: helpdeskInstance.id
        }
    }

    def delete(Long id) {
        Helpdesk helpdeskInstance = Helpdesk.get(id)
        if (!helpdeskInstance) {
            flash.message = message(
                code: 'default.not.found.message',
                args: [message(code: 'helpdesk.label'), id]
            )

            if (params.returnUrl) {
                redirect url: params.returnUrl
            } else {
                redirect action: 'index'
            }
            return
        }

        try {
            helpdeskInstance.delete flush: true
            flash.message = message(
                code: 'default.deleted.message',
                args: [message(code: 'helpdesk.label')]
            )

            if (params.returnUrl) {
                redirect url: params.returnUrl
            } else {
                redirect action: 'index'
            }
        } catch (DataIntegrityViolationException e) {
            flash.message = message(
                code: 'default.not.deleted.message',
                args: [message(code: 'helpdesk.label')]
            )
            redirect action: 'show', id: id
        }
    }

    def frontendIndex(String urlName, String accessCode) {
        Helpdesk helpdeskInstance = Helpdesk.findByUrlName(urlName)
        if (!helpdeskInstance) {
            render status: SC_NOT_FOUND
            return
        }

        def ticketInstanceList =
            Ticket.findAllByHelpdesk(helpdeskInstance, params)

        [
            helpdeskInstance: helpdeskInstance,
            ticketInstanceList: ticketInstanceList
        ]
    }
}
