part of './Constants.dart';

 enum GResultType {
   All, Videos, News, Images, Maps, Shopping, Books, Flights
 }

 extension GResultTypeToString on GResultType {

   String get string => this.toString().split('.').last;//sample: GResultType.Videos => => "GresultType, Videos" [GresultType, Videos] => Videos;
 }



 enum OptionType {
   Memory, Storage, Ethernet, FinalCutPro, LogicPro
 }