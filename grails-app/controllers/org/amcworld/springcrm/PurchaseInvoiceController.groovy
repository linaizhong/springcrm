package org.amcworld.springcrm

import net.sf.jmimemagic.Magic
import org.springframework.dao.DataIntegrityViolationException

class PurchaseInvoiceController {

    static allowedMethods = [save: 'POST', update: 'POST', delete: 'GET']

	def fileService
	def seqNumberService

    def index() {
        redirect(action: 'list', params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        return [purchaseInvoiceInstanceList: PurchaseInvoice.list(params), purchaseInvoiceInstanceTotal: PurchaseInvoice.count()]
    }

	def listEmbedded() {
		def organizationInstance = Organization.get(params.organization)
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		return [purchaseInvoiceInstanceList: PurchaseInvoice.findAllByVendor(organizationInstance, params), purchaseInvoiceInstanceTotal: PurchaseInvoice.countByVendor(organizationInstance), linkParams: [organization: organizationInstance.id]]
	}

    def create() {
        def purchaseInvoiceInstance = new PurchaseInvoice()
        purchaseInvoiceInstance.properties = params
        return [purchaseInvoiceInstance: purchaseInvoiceInstance]
    }

	def copy() {
		def purchaseInvoiceInstance = PurchaseInvoice.get(params.id)
		if (!purchaseInvoiceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'purchaseInvoice.label', default: 'PurchaseInvoice'), params.id])
            redirect(action: 'list')
            return
        }

		purchaseInvoiceInstance = new PurchaseInvoice(purchaseInvoiceInstance)
		render(view: 'create', model: [purchaseInvoiceInstance: purchaseInvoiceInstance])
	}

    def save() {
        def purchaseInvoiceInstance = new PurchaseInvoice(params)
		if (!params.file.isEmpty()) {
			purchaseInvoiceInstance.documentFile = fileService.storeFile(params.file)
		}
        if (!purchaseInvoiceInstance.save(flush: true)) {
            render(view: 'create', model: [purchaseInvoiceInstance: purchaseInvoiceInstance])
            return
        }

		purchaseInvoiceInstance.index()
        flash.message = message(code: 'default.created.message', args: [message(code: 'purchaseInvoice.label', default: 'PurchaseInvoice'), purchaseInvoiceInstance.toString()])
		if (params.returnUrl) {
			redirect(url: params.returnUrl)
		} else {
			redirect(action: 'show', id: purchaseInvoiceInstance.id)
		}
    }

    def show() {
        def purchaseInvoiceInstance = PurchaseInvoice.get(params.id)
        if (!purchaseInvoiceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'purchaseInvoice.label', default: 'PurchaseInvoice'), params.id])
            redirect(action: 'list')
            return
        }

        return [purchaseInvoiceInstance: purchaseInvoiceInstance]
    }

    def edit() {
        def purchaseInvoiceInstance = PurchaseInvoice.get(params.id)
        if (!purchaseInvoiceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'purchaseInvoice.label', default: 'PurchaseInvoice'), params.id])
            redirect(action: 'list')
            return
        }

        return [purchaseInvoiceInstance: purchaseInvoiceInstance]
    }

    def update() {
        def purchaseInvoiceInstance = PurchaseInvoice.get(params.id)
        if (!purchaseInvoiceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'purchaseInvoice.label', default: 'PurchaseInvoice'), params.id])
            redirect(action: 'list')
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (purchaseInvoiceInstance.version > version) {

                purchaseInvoiceInstance.errors.rejectValue('version', 'default.optimistic.locking.failure', [message(code: 'purchaseInvoice.label', default: 'PurchaseInvoice')] as Object[], "Another user has updated this PurchaseInvoice while you were editing")
                render(view: 'edit', model: [purchaseInvoiceInstance: purchaseInvoiceInstance])
                return
            }
        }
        purchaseInvoiceInstance.properties = params
		if (params.fileRemove == '1') {
			if (purchaseInvoiceInstance.documentFile) {
				fileService.removeFile(purchaseInvoiceInstance.documentFile)
			}
			purchaseInvoiceInstance.documentFile = null;
		} else if (!params.file?.isEmpty()) {
			if (purchaseInvoiceInstance.documentFile) {
				fileService.removeFile(purchaseInvoiceInstance.documentFile)
			}
			purchaseInvoiceInstance.documentFile = fileService.storeFile(params.file)
		}
        purchaseInvoiceInstance.items?.retainAll { it != null }
        if (!purchaseInvoiceInstance.save(flush: true)) {
            render(view: 'edit', model: [purchaseInvoiceInstance: purchaseInvoiceInstance])
            return
        }

		purchaseInvoiceInstance.reindex()
        flash.message = message(code: 'default.updated.message', args: [message(code: 'purchaseInvoice.label', default: 'PurchaseInvoice'), purchaseInvoiceInstance.toString()])
		if (params.returnUrl) {
			redirect(url: params.returnUrl)
		} else {
			redirect(action: 'show', id: purchaseInvoiceInstance.id)
		}
    }

    def delete() {
        def purchaseInvoiceInstance = PurchaseInvoice.get(params.id)
        if (purchaseInvoiceInstance && params.confirmed) {
			if (purchaseInvoiceInstance.documentFile) {
				fileService.removeFile(purchaseInvoiceInstance.documentFile)
			}
            try {
                purchaseInvoiceInstance.delete(flush: true)
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'purchaseInvoice.label', default: 'PurchaseInvoice')])
				if (params.returnUrl) {
					redirect(url: params.returnUrl)
				} else {
					redirect(action: 'list')
				}
            } catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'purchaseInvoice.label', default: 'PurchaseInvoice')])
                redirect(action: 'show', id: params.id)
            }
        } else {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'purchaseInvoice.label', default: 'PurchaseInvoice'), params.id])
			if (params.returnUrl) {
				redirect(url: params.returnUrl)
			} else {
				redirect(action: 'list')
			}
        }
    }

	def getDocument() {
        def purchaseInvoiceInstance = PurchaseInvoice.get(params.id)
        if (purchaseInvoiceInstance) {
			String doc = purchaseInvoiceInstance.documentFile
			File f = fileService.retrieveFile(doc)
			if (f.exists()) {
				response.contentType = Magic.getMagicMatch(f, true).mimeType
				response.contentLength = f.length()
				response.addHeader 'Content-Disposition',
					"attachment; filename=\"${doc}\""
				response.outputStream << f.newInputStream()
				return null
			}
		}
		render(status: 404)
	}
}
