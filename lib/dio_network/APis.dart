enum APIType {
  login,
  searchCustomer,
  addCustomer,
  searchMerchantInvoices,
  getInvoiceDetails,
  getProductDetails,
  getPaymentMethods,
  getNotificationMethods,
  getSalesTarget,
  getBankAccountsList,
  createInvoice,
  sendNotifications
}

class ApiConstants {
  //static const baseUrl = "http://207.244.105.191:8866/";
  static const baseUrl = " http://103.121.224.130:8899/";

  static const loginUser = 'api/app/login/authentication/';
  static const searchCustomer = 'products/search_merchant_customer/';
  static const addCustomer = 'products/add_merchant_customer/';
  static const searchMerchantInvoices =
      'products/search_merchant_customer_invoice/';
  static const getInvoiceDetails = '/products/invoice_details_app/';
  static const getProductDetails = '/products/get_data_imei_app/';
  static const getPaymentMethods = '/products/payment_method_api_app/';
  static const getNotificationMethods =
      '/products/notification_method_api_app/';
  static const getSalesTarget = '/sale_target/api/app/get_sale_record/';
  static const getBankAccountsList = '/products/bank_account_list_api_app/';
  static const createInvoice = 'products/sale_product_submit_app/';
  static const sendNotifications = '/products/send_invoice_app/';
}
