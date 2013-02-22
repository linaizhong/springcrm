/*
 * SalesOrderController.groovy
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
 * The class {@code SalesOrderController} contains actions which manage sales
 * orders.
 *
 * @author	Daniel Ellermann
 * @version 1.3
 */
class SalesOrderController {

    //-- Class variables ------------------------

    static allowedMethods = [save: 'POST', update: 'POST', delete: 'GET']


    //-- Instance variables ---------------------

	def fopService
	def seqNumberService


    //-- Public methods -------------------------

	def index() {
        redirect(action: 'list', params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        def list, count
        if (params.search) {
            String searchFilter = "%${params.search}%".toString()
            list = SalesOrder.findAllBySubjectLike(searchFilter, params)
            count = SalesOrder.countBySubjectLike(searchFilter)
        } else {
            list = SalesOrder.list(params)
            count = SalesOrder.count()
        }

        return [salesOrderInstanceList: list, salesOrderInstanceTotal: count]
    }

	def listEmbedded() {
		def l
		def count
		def linkParams
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		if (params.organization) {
			def organizationInstance = Organization.get(params.organization)
			l = SalesOrder.findAllByOrganization(organizationInstance, params)
			count = SalesOrder.countByOrganization(organizationInstance)
			linkParams = [organization: organizationInstance.id]
		} else if (params.person) {
			def personInstance = Person.get(params.person)
			l = SalesOrder.findAllByPerson(personInstance, params)
			count = SalesOrder.countByPerson(personInstance)
			linkParams = [person: personInstance.id]
		} else if (params.quote) {
			def quoteInstance = Quote.get(params.quote)
			l = SalesOrder.findAllByQuote(quoteInstance, params)
			count = SalesOrder.countByQuote(quoteInstance)
			linkParams = [quote: quoteInstance.id]
		}
		return [salesOrderInstanceList: l, salesOrderInstanceTotal: count, linkParams: linkParams]
	}

    def create() {
        def salesOrderInstance
		if (params.quote) {
			def quoteInstance = Quote.get(params.quote)
			salesOrderInstance = new SalesOrder(quoteInstance)
		} else {
			salesOrderInstance = new SalesOrder()
			salesOrderInstance.properties = params
		}
		Organization org = salesOrderInstance.organization
		if (org) {
			salesOrderInstance.billingAddrCountry = org.billingAddrCountry
			salesOrderInstance.billingAddrLocation = org.billingAddrLocation
			salesOrderInstance.billingAddrPoBox = org.billingAddrPoBox
			salesOrderInstance.billingAddrPostalCode = org.billingAddrPostalCode
			salesOrderInstance.billingAddrState = org.billingAddrState
			salesOrderInstance.billingAddrStreet = org.billingAddrStreet
			salesOrderInstance.shippingAddrCountry = org.shippingAddrCountry
			salesOrderInstance.shippingAddrLocation = org.shippingAddrLocation
			salesOrderInstance.shippingAddrPoBox = org.shippingAddrPoBox
			salesOrderInstance.shippingAddrPostalCode = org.shippingAddrPostalCode
			salesOrderInstance.shippingAddrState = org.shippingAddrState
			salesOrderInstance.shippingAddrStreet = org.shippingAddrStreet
		}
        return [salesOrderInstance: salesOrderInstance]
    }

	def copy() {
		def salesOrderInstance = SalesOrder.get(params.id)
		if (!salesOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'salesOrder.label', default: 'SalesOrder'), params.id])
            redirect(action: 'list')
            return
        }

		salesOrderInstance = new SalesOrder(salesOrderInstance)
		render(view: 'create', model: [salesOrderInstance: salesOrderInstance])
	}

    def save() {
        def salesOrderInstance = new SalesOrder(params)
        if (!salesOrderInstance.save(flush: true)) {
            log.debug(salesOrderInstance.errors)
            render(view: 'create', model: [salesOrderInstance: salesOrderInstance])
            return
        }
        params.id = salesOrderInstance.ident()

		salesOrderInstance.index()
        flash.message = message(code: 'default.created.message', args: [message(code: 'salesOrder.label', default: 'SalesOrder'), salesOrderInstance.toString()])
		if (params.returnUrl) {
			redirect(url: params.returnUrl)
		} else {
			redirect(action: 'show', id: salesOrderInstance.id)
		}
    }

    def show() {
        def salesOrderInstance = SalesOrder.get(params.id)
        if (!salesOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'salesOrder.label', default: 'SalesOrder'), params.id])
            redirect(action: 'list')
            return
        }

        return [salesOrderInstance: salesOrderInstance, printTemplates: fopService.templateNames]
    }

    def edit() {
        def salesOrderInstance = SalesOrder.get(params.id)
        if (!salesOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'salesOrder.label', default: 'SalesOrder'), params.id])
            redirect(action: 'list')
            return
        }

        return [salesOrderInstance: salesOrderInstance]
    }

    def update() {
        def salesOrderInstance = SalesOrder.get(params.id)
        if (!salesOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'salesOrder.label', default: 'SalesOrder'), params.id])
            redirect(action: 'list')
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (salesOrderInstance.version > version) {
                salesOrderInstance.errors.rejectValue('version', 'default.optimistic.locking.failure', [message(code: 'salesOrder.label', default: 'SalesOrder')] as Object[], "Another user has updated this SalesOrder while you were editing")
                render(view: 'edit', model: [salesOrderInstance: salesOrderInstance])
                return
            }
        }
		if (params.autoNumber) {
			params.number = salesOrderInstance.number
		}

        /*
         * The original implementation which worked in Grails 2.0.0.
         */
        salesOrderInstance.properties = params
//        salesOrderInstance.items?.retainAll { it != null }

        /*
         * XXX  This code is necessary because the default implementation
         *      in Grails does not work.  The above lines worked in Grails
         *      2.0.0.  Now, either data binding or saving does not work
         *      correctly if items were deleted and gaps in the indices
         *      occurred (e. g. 0, 1, null, null, 4) or the items were
         *      re-ordered.  Then I observed cluttering in saved data
         *      columns.
         *      The following lines do not make me happy but they work.
         *      In future, this problem hopefully will be fixed in Grails
         *      so we can remove these lines.
         */
        salesOrderInstance.items?.clear()
        for (int i = 0; params."items[${i}]"; i++) {
            if (params."items[${i}]".id != 'null') {
                salesOrderInstance.addToItems(params."items[${i}]")
            }
        }

        if (!salesOrderInstance.save(flush: true)) {
            log.debug(salesOrderInstance.errors)
            render(view: 'edit', model: [salesOrderInstance: salesOrderInstance])
            return
        }

		salesOrderInstance.reindex()
        flash.message = message(code: 'default.updated.message', args: [message(code: 'salesOrder.label', default: 'SalesOrder'), salesOrderInstance.toString()])
		if (params.returnUrl) {
			redirect(url: params.returnUrl)
		} else {
			redirect(action: 'show', id: salesOrderInstance.id)
		}
    }

    def delete() {
        def salesOrderInstance = SalesOrder.get(params.id)
        if (!salesOrderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'salesOrder.label', default: 'SalesOrder'), params.id])
            if (params.returnUrl) {
                redirect(url: params.returnUrl)
            } else {
                redirect(action: 'list')
            }
            return
        }

        try {
            salesOrderInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'salesOrder.label', default: 'SalesOrder')])
			if (params.returnUrl) {
				redirect(url: params.returnUrl)
			} else {
				redirect(action: 'list')
			}
        } catch (org.springframework.dao.DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'salesOrder.label', default: 'SalesOrder')])
            redirect(action: 'show', id: params.id)
        }
    }

	def find() {
		Integer number = null
		try {
			number = params.name as Integer
		} catch (NumberFormatException ignored) { /* ignored */ }
		def organization = params.organization ? Organization.get(params.organization) : null

		def c = SalesOrder.createCriteria()
		def list = c.list {
			or {
				eq('number', number)
				ilike('subject', "%${params.name}%")
			}
			if (organization) {
				and {
					eq('organization', organization)
				}
			}
			order('number', 'desc')
		}

		render(contentType: "text/json") {
			array {
				for (so in list) {
					salesOrder id: so.id, name: so.fullName
				}
			}
		}
	}

	def print() {
        def salesOrderInstance = SalesOrder.get(params.id)
        if (!salesOrderInstance) {
            render(status: 404)
            return
        }

        String xml = fopService.generateXml(
            salesOrderInstance, !!params.duplicate
        )
		GString fileName = "${message(code: 'salesOrder.label')} ${salesOrderInstance.fullNumber}"
		if (params.duplicate) {
			fileName += " (${message(code: 'invoicingTransaction.duplicate')})"
		}
		fileName += ".pdf"

        fopService.outputPdf(
            xml, 'sales-order', params.template, response, fileName
        )
	}
}
