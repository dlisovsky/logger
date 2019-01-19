({
	init : function(component) {

		var log = component.get('v.log');
		if(log) {

			var metadataJSON = log.hey__Details__c;
			var dataJSON = log.hey__Data__c;

			var metadata = JSON.parse(metadataJSON);

			component.set('v.metadata', metadata)
			component.set('v.metadataPrettyStr', JSON.stringify(metadata, null, 4))

			var logItems = JSON.parse(dataJSON)
			component.set('v.logItems', logItems);

			component.set('v.createdOn', new Date(log.CreatedDate))
			component.set('v.createdOnStr', $A.localizationService.formatDateTime(new Date(log.CreatedDate)))

			this.calculateCountByTypes(component);
		}
	},

	calculateCountByTypes: function (component) {
		var logItems = component.get('v.logItems');

		var aggregation = {
			'DEBUG': {
				count: 0,
				class: 'slds-theme--info'
			},
			'INFO': {
				count: 0,
				class: 'slds-theme--warning'
			},
			'ERROR' : {
				class: 'slds-theme--error',
				count: 0
			},
			'EXCEPTION' : {
				class: 'slds-theme--error',
				count: 0
			}
		};
		logItems.forEach(function (logItem) {
			var aggr = aggregation[logItem.type] || {type: logItem.type};
			aggr.count = (aggr.count || 0) + 1;
			aggregation[logItem.type] = aggr;
		})


		var countByTypes = [];

		for(var type in aggregation){

			var aggr = aggregation[type] || {};

			countByTypes.push({
				type: type,
				count: aggr.count || 0,
				class: aggr.class
			});
		}

		component.set('v.countByTypes', countByTypes);
	}
})