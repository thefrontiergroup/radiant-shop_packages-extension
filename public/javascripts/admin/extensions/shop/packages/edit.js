document.observe("dom:loaded", function() {
  shop_package_edit = new ShopPackageEdit();
  shop_package_edit.initialize();
  
  Event.addBehavior({
    '#available_products .product:click'  : function(e) { shop_package_edit.productAttach($(this)) },
    '#package_products .quantity:blur'    : function(e) { shop_package_edit.productUpdate($(this)) },
    '#package_products .delete:click'     : function(e) { shop_package_edit.productRemove($(this)) }
  })
});

var ShopPackageEdit = Class.create({
  
  initialize: function() {
    this.productsSort();
  },
  
  productsSort: function() {
    var route = shop.getRoute('sort_admin_shop_package_packings_path');    
    Sortable.create('package_products', {
      constraint:   false, 
      overlap:      'horizontal',
      containment:  ['package_products'],
      onUpdate: function(element) {
        new Ajax.Request(route, {
          method: 'put',
          parameters: {
            'package_id': $('shop_package_id').value,
            'packings'  : Sortable.serialize('package_products')
          }
        });
      }
    })
  },
  
  productAttach: function(element) {
    var product = element;
    var route   = shop.getRoute('admin_shop_package_packings_path');
    
    showStatus('Adding Product...');
    new Ajax.Request(route, {
      method: 'post',
      parameters: {
        'package_id': $('shop_package_id').value,
        'product_id': element.getAttribute('data-product_id'),
      },
      onSuccess: function(data) {
        $('package_products').insert({ 'bottom' : data.responseText});
        shop_package_edit.productPostChanges(product);
      }.bind(element),
      onFailure: function() {
        thi.productError();
      }
    });
  },
  
  productUpdate: function(element) {
    var product    = element.up('.product');
    var packing_id = product.readAttribute('data-packing_id');
    var route      = shop.getRoute('admin_shop_package_packing_path', 'js', packing_id);
    
    showStatus('Updating Quantity...');
    new Ajax.Request(route, { 
      method: 'put',
      parameters: {
        'quantity': element.value
      },
      onSuccess: function(data) {
        hideStatus();
      },
      onFailure: function(data) {
        shop_package_edit.errorStatus();
      }
    });
  },
  
  productRemove: function(element) {
    var product    = element.up('.product');
    var packing_id = product.readAttribute('data-packing_id');
    var route      = shop.getRoute('admin_shop_package_packing_path', 'js', packing_id);
    
    showStatus('Removing Product...');
    element.hide();
    new Ajax.Request(route, { 
      method: 'delete',
      onSuccess: function(data) {
        $('available_products').insert({ 'bottom' : data.responseText });
        shop_package_edit.productPostChanges(product);
      },
      onFailure: function(data) {
        shop_package_edit.errorStatus();
      }
    });
  },
  
  productPostChanges: function(element) {
    element.remove();
    
    this.productsSort();
    
    hideStatus();
  },
  
  errorStatus: function() {
    setStatus('Something went wrong, refreshing.');
    location.reload(true);
  }
  
});