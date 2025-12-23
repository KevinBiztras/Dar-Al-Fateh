import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/models/OrderDetailModel.dart';
import 'package:geocoding/geocoding.dart';
import 'order_heading_view.dart';

class OrderDeliveryDetails extends StatelessWidget {
  final AppLocalizations? localization;
  final OrderDetailModel? orderDetailModel;

  const OrderDeliveryDetails(
      {Key? key, this.localization, this.orderDetailModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return orderHeaderLayout(
        context,
        localization?.translate(AppStringConstant.deliveryDetails) ?? '',
        ListView.builder(
            shrinkWrap: true,
            itemCount: orderDetailModel?.pickingDetails?.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            orderDetailModel?.pickingDetails?[index].name ?? '',
                            style: Theme.of(context).textTheme.bodyMedium),
                        ((orderDetailModel?.pickingDetails?[index]
                                        .deliveryBoyId !=
                                    null) &&
                                (orderDetailModel!
                                        .pickingDetails![index].deliveryBoyId! >
                                    0))
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                                onPressed: () async {
                                  double shippingLatitude = double.parse('0');
                                  double shippingLongitude = double.parse('0');

                                  if ((orderDetailModel?.pickingDetails?[index]
                                                  .lat !=
                                              null &&
                                          orderDetailModel!
                                              .pickingDetails![index]
                                              .lat!
                                              .isNotEmpty) &&
                                      (orderDetailModel?.pickingDetails?[index].long !=
                                              null &&
                                          orderDetailModel!
                                              .pickingDetails![index]
                                              .long!
                                              .isNotEmpty)) {
                                    shippingLatitude = double.parse(
                                        orderDetailModel
                                                ?.pickingDetails?[index].lat ??
                                            '0');
                                    shippingLongitude = double.parse(
                                        orderDetailModel
                                                ?.pickingDetails?[index].long ??
                                            '0');
                                  } else if (orderDetailModel
                                              ?.deliveryLatitude !=
                                          null &&
                                      orderDetailModel?.deliveryLongitude !=
                                          null &&
                                      orderDetailModel!
                                          .deliveryLatitude!.isNotEmpty &&
                                      orderDetailModel!
                                          .deliveryLongitude!.isNotEmpty) {
                                    shippingLatitude = double.parse(
                                        orderDetailModel?.deliveryLatitude ??
                                            '0');
                                    shippingLongitude = double.parse(
                                        orderDetailModel?.deliveryLongitude ??
                                            '0');
                                  } else {
                                    List<Location> locations =
                                        await locationFromAddress(
                                            orderDetailModel?.shippingAddress ??
                                                '');
                                    if (locations.isNotEmpty) {
                                      Location location = locations.first;
                                      shippingLatitude = location.latitude;
                                      shippingLongitude = location.longitude;
                                    }
                                  }
                                  Navigator.of(context).pushNamed(
                                      deliveryTrackingScreen,
                                      arguments: getOrderTrackingDataMap(
                                          orderDetailModel
                                                  ?.pickingDetails?[index]
                                                  .deliveryBoyId
                                                  .toString() ??
                                              '',
                                          orderDetailModel?.shippingAddress ??
                                              '',
                                          shippingLatitude,
                                          shippingLongitude,
                                          orderDetailModel
                                              ?.pickingDetails?[index]
                                              .warehouseDetails));
                                },
                                child: Text(
                                    localization?.translate(
                                            AppStringConstant.trackOrder) ??
                                        '',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer)),
                              )
                            : Container()
                        //: const SizedBox.shrink(),
                      ],
                    ),
                    Text(orderDetailModel?.pickingDetails?[index].status ?? '',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              );
            }));
  }
}
