var Employee = Backbone.Model.extend({
    defaults: {
        name: '',
        company : '',
        created : '',
        modified : '',
        isActive : false,
        templatepaycheck : '',
        paychecks : []
    }
});