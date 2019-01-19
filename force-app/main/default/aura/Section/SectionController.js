({
	handleInit: function (component, event, helper) {
		var isNowOpen = component.get('v.isOpen');

		if(isNowOpen){
			component.set('v.isViewed', true);
		}
	},

	handleSectionTitle: function (component, event, helper) {

		var isNowOpen = component.get('v.isOpen');

		component.set('v.isOpen', !isNowOpen);
		component.set('v.isViewed', true);
	}
})