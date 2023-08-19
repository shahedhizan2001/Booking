import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

const kTransparentImage = const Color(0x00000000);

Widget rowSection(
    {required var country,
      required var city,
      required var name,
      required var image,
      required VoidCallback h}) =>
    GestureDetector(
      onTap: h,
      child: CachedNetworkImage(
        imageUrl: image,
        imageBuilder: (context, imageProvider) => Container(
          child: Stack(
            children: [
              Positioned(
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: FadeInImage(
                          placeholder: AssetImage('assets/image/photo_2023-07-26_03-13-33.jpg'),
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                          width: 250,
                          height: 200,
                        )

                      // Image(
                      //   image: NetworkImage(image),
                      //   fit: BoxFit.cover,
                      //   width: 250,
                      //   height: 200,
                      // ),
                    ),
                  )),
              Positioned(
                  bottom: 20,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            country,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            ", " + city,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
        // placeholder: (context, url) => Positioned(
        //   child: Container(
        //     width: 250,
        //     alignment: Alignment.center,
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.circular(15),
        //       child: CircularProgressIndicator(),
        //
        //     ),//CircularProgressIndicator(),
        //   ),
        // ),
      ),
    );