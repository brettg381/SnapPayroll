package com.intuit.ems.spw

import org.springframework.dao.DataIntegrityViolationException

class PaycheckController {
    def scaffold = true 
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [paycheckInstanceList: Paycheck.list(params), paycheckInstanceTotal: Paycheck.count()]
    }

    def create() {
        [paycheckInstance: new Paycheck(params)]
    }

    def save() {
        def paycheckInstance = new Paycheck(params)
        if (!paycheckInstance.save(flush: true)) {
            render(view: "create", model: [paycheckInstance: paycheckInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'paycheck.label', default: 'Paycheck'), paycheckInstance.id])
        redirect(action: "show", id: paycheckInstance.id)
    }

    def show(Long id) {
        def paycheckInstance = Paycheck.get(id)
        if (!paycheckInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'paycheck.label', default: 'Paycheck'), id])
            redirect(action: "list")
            return
        }

        [paycheckInstance: paycheckInstance]
    }

    def edit(Long id) {
        def paycheckInstance = Paycheck.get(id)
        if (!paycheckInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'paycheck.label', default: 'Paycheck'), id])
            redirect(action: "list")
            return
        }

        [paycheckInstance: paycheckInstance]
    }

    def update(Long id, Long version) {
        def paycheckInstance = Paycheck.get(id)
        if (!paycheckInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'paycheck.label', default: 'Paycheck'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (paycheckInstance.version > version) {
                paycheckInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'paycheck.label', default: 'Paycheck')] as Object[],
                          "Another user has updated this Paycheck while you were editing")
                render(view: "edit", model: [paycheckInstance: paycheckInstance])
                return
            }
        }

        paycheckInstance.properties = params

        if (!paycheckInstance.save(flush: true)) {
            render(view: "edit", model: [paycheckInstance: paycheckInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'paycheck.label', default: 'Paycheck'), paycheckInstance.id])
        redirect(action: "show", id: paycheckInstance.id)
    }

    def delete(Long id) {
        def paycheckInstance = Paycheck.get(id)
        if (!paycheckInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'paycheck.label', default: 'Paycheck'), id])
            redirect(action: "list")
            return
        }

        try {
            paycheckInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'paycheck.label', default: 'Paycheck'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'paycheck.label', default: 'Paycheck'), id])
            redirect(action: "show", id: id)
        }
    }
}
