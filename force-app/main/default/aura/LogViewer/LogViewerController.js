({
	handleInit: function(component, event, helper) {

		component.utils.callApex(
			component.get('c.retrieveMetadata'),
			{},
			function (responseJSON) {
				var response = JSON.parse(responseJSON);
				component.set('v.metadata', response);
				component.set('v.isBusy', false);
			}, function (errors) {
				component.utils.showToast({
					message: errors && errors.length ? errors[0].message : 'Unknown error',
					type: 'error'
				});
				component.set('v.isBusy', false);
			}
		);

	},

	handleMessage: function(component, event, helper) {

		var logs = component.get('v.logs');
		var log = event.getParam("payload");

		console.log(JSON.stringify(log));

		if(log){
			logs = logs || [];
			logs.unshift(log);
			component.set('v.logs', logs);
		}
	},

	handleError: function(component, event, helper) {

		var status = event.getParam("payload");
		component.utils.showToast({
			message: status ? JSON.stringify(status) : 'Unknown Error',
			type: 'error',
			mode: 'sticky'
		});
	},

	handleClearClick: function(component, event, helper) {
		component.set("v.logs", []);
	}
})