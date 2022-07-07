class StatisticsModel {

  int? canceled_orders;
  int? customers_count;
  int? finished_orders;
  int? total_orders;
  int? services;
  int? workers_count;

  StatisticsModel({
    this.canceled_orders,
    this.customers_count,
    this.finished_orders,
    this.services,
    this.workers_count,
    this.total_orders,

  });

  StatisticsModel.fromJson(Map<String, dynamic> json) {
    canceled_orders = json['canceled_orders'];
    customers_count = json['customers_count'];
    finished_orders = json['finished_orders'];
    services = json['services'];
    total_orders = json['total_orders'];
    workers_count = json['workers_count'];

  }

  StatisticsModel.fromDynamic(dynamic json) {
    canceled_orders = json['canceled_orders'];
    customers_count = json['customers_count'];
    finished_orders = json['finished_orders'];
    services = json['services'];
    total_orders = json['total_orders'];
    workers_count = json['workers_count'];

  }
}
