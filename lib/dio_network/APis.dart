enum APIType {
  login,
  searchCustomer,
  addCustomer,
  searchMerchantInvoices,
  getInvoiceDetails,
  getProductDetails,
}

class ApiConstants {
  static const baseUrl = "http://207.244.105.191:8866/";
  static const loginUser = 'api/app/login/authentication/';
  static const searchCustomer = 'products/search_merchant_customer/';
  static const addCustomer = 'products/add_merchant_customer/';
  static const searchMerchantInvoices =
      'products/search_merchant_customer_invoice/';
  static const getInvoiceDetails = '/products/invoice_details_app/';

  static const getProductDetails = '/products/get_data_imei_app/';
}
