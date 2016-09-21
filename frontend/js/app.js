var Shop = {};
Shop.Model = Backbone.Model.extend();
Shop.Collection = Backbone.Collection.extend({
	model: Shop.Model,
	url: 'http://localhost:3000/products',
	parse: function (response) {
		console.log(response);
	}
});
var collection = new Shop.Collection();
collection.fetch({
	dataType: 'jsonp'
});