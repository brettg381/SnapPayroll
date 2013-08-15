package com.intuit.ems.spw



import org.junit.*
import grails.test.mixin.*

@TestFor(PaycheckController)
@Mock(Paycheck)
class PaycheckControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/paycheck/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.paycheckInstanceList.size() == 0
        assert model.paycheckInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.paycheckInstance != null
    }

    void testSave() {
        controller.save()

        assert model.paycheckInstance != null
        assert view == '/paycheck/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/paycheck/show/1'
        assert controller.flash.message != null
        assert Paycheck.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/paycheck/list'

        populateValidParams(params)
        def paycheck = new Paycheck(params)

        assert paycheck.save() != null

        params.id = paycheck.id

        def model = controller.show()

        assert model.paycheckInstance == paycheck
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/paycheck/list'

        populateValidParams(params)
        def paycheck = new Paycheck(params)

        assert paycheck.save() != null

        params.id = paycheck.id

        def model = controller.edit()

        assert model.paycheckInstance == paycheck
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/paycheck/list'

        response.reset()

        populateValidParams(params)
        def paycheck = new Paycheck(params)

        assert paycheck.save() != null

        // test invalid parameters in update
        params.id = paycheck.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/paycheck/edit"
        assert model.paycheckInstance != null

        paycheck.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/paycheck/show/$paycheck.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        paycheck.clearErrors()

        populateValidParams(params)
        params.id = paycheck.id
        params.version = -1
        controller.update()

        assert view == "/paycheck/edit"
        assert model.paycheckInstance != null
        assert model.paycheckInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/paycheck/list'

        response.reset()

        populateValidParams(params)
        def paycheck = new Paycheck(params)

        assert paycheck.save() != null
        assert Paycheck.count() == 1

        params.id = paycheck.id

        controller.delete()

        assert Paycheck.count() == 0
        assert Paycheck.get(paycheck.id) == null
        assert response.redirectedUrl == '/paycheck/list'
    }
}
