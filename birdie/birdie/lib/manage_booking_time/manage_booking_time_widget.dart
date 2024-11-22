import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'manage_booking_time_model.dart';
export 'manage_booking_time_model.dart';

class ManageBookingTimeWidget extends StatefulWidget {
  const ManageBookingTimeWidget({super.key});

  @override
  State<ManageBookingTimeWidget> createState() =>
      _ManageBookingTimeWidgetState();
}

class _ManageBookingTimeWidgetState extends State<ManageBookingTimeWidget> {
  late ManageBookingTimeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ManageBookingTimeModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return AuthUserStreamWidget(
      builder: (context) => StreamBuilder<BookingRecord>(
        stream: BookingRecord.getDocument(currentUserDocument!.bookRef!),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              body: Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
              ),
            );
          }

          final manageBookingTimeBookingRecord = snapshot.data!;

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              appBar: AppBar(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                automaticallyImplyLeading: false,
                title: Text(
                  'Manage Booking Time',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                      ),
                ),
                actions: [],
                centerTitle: false,
                elevation: 2.0,
              ),
              body: SafeArea(
                top: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Monday',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {
                                        final _datePicked1Time =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                              getCurrentTimestamp),
                                          builder: (context, child) {
                                            return wrapInMaterialTimePickerTheme(
                                              context,
                                              child!,
                                              headerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              headerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              headerTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 32.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                              pickerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              pickerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              selectedDateTimeBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              selectedDateTimeForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              actionButtonForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              iconSize: 24.0,
                                            );
                                          },
                                        );
                                        if (_datePicked1Time != null) {
                                          safeSetState(() {
                                            _model.datePicked1 = DateTime(
                                              getCurrentTimestamp.year,
                                              getCurrentTimestamp.month,
                                              getCurrentTimestamp.day,
                                              _datePicked1Time.hour,
                                              _datePicked1Time.minute,
                                            );
                                          });
                                        }
                                        FFAppState().updateAvailabilityAtIndex(
                                          0,
                                          (e) =>
                                              e..startTime = _model.datePicked1,
                                        );
                                        safeSetState(() {});
                                      },
                                      text: FFAppState()
                                                  .availability[0]
                                                  .startTime ==
                                              null
                                          ? 'Start Time'
                                          : (FFAppState()
                                                  .availability[0]
                                                  .hasStartTime()
                                              ? dateTimeFormat(
                                                  "jm",
                                                  FFAppState()
                                                      .availability[0]
                                                      .startTime!)
                                              : dateTimeFormat(
                                                  "jm", _model.datePicked1)),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        final _datePicked2Time =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                              getCurrentTimestamp),
                                          builder: (context, child) {
                                            return wrapInMaterialTimePickerTheme(
                                              context,
                                              child!,
                                              headerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              headerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              headerTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 32.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                              pickerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              pickerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              selectedDateTimeBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              selectedDateTimeForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              actionButtonForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              iconSize: 24.0,
                                            );
                                          },
                                        );
                                        if (_datePicked2Time != null) {
                                          safeSetState(() {
                                            _model.datePicked2 = DateTime(
                                              getCurrentTimestamp.year,
                                              getCurrentTimestamp.month,
                                              getCurrentTimestamp.day,
                                              _datePicked2Time.hour,
                                              _datePicked2Time.minute,
                                            );
                                          });
                                        }
                                        FFAppState().updateAvailabilityAtIndex(
                                          0,
                                          (e) =>
                                              e..endTime = _model.datePicked2,
                                        );
                                        safeSetState(() {});
                                      },
                                      text: FFAppState()
                                                  .availability[0]
                                                  .endTime ==
                                              null
                                          ? 'End Time'
                                          : (FFAppState()
                                                  .availability[0]
                                                  .hasEndTime()
                                              ? dateTimeFormat(
                                                  "jm",
                                                  FFAppState()
                                                      .availability[0]
                                                      .endTime!)
                                              : dateTimeFormat(
                                                  "jm", _model.datePicked1)),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Tuesday',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {
                                        final _datePicked3Time =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                              getCurrentTimestamp),
                                          builder: (context, child) {
                                            return wrapInMaterialTimePickerTheme(
                                              context,
                                              child!,
                                              headerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              headerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              headerTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 32.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                              pickerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              pickerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              selectedDateTimeBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              selectedDateTimeForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              actionButtonForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              iconSize: 24.0,
                                            );
                                          },
                                        );
                                        if (_datePicked3Time != null) {
                                          safeSetState(() {
                                            _model.datePicked3 = DateTime(
                                              getCurrentTimestamp.year,
                                              getCurrentTimestamp.month,
                                              getCurrentTimestamp.day,
                                              _datePicked3Time.hour,
                                              _datePicked3Time.minute,
                                            );
                                          });
                                        }
                                        FFAppState().updateAvailabilityAtIndex(
                                          1,
                                          (e) =>
                                              e..startTime = _model.datePicked3,
                                        );
                                        safeSetState(() {});
                                      },
                                      text: FFAppState()
                                                  .availability[1]
                                                  .startTime ==
                                              null
                                          ? 'Start Time'
                                          : (FFAppState()
                                                  .availability[1]
                                                  .hasStartTime()
                                              ? dateTimeFormat(
                                                  "jm",
                                                  FFAppState()
                                                      .availability[1]
                                                      .startTime!)
                                              : dateTimeFormat(
                                                  "jm", _model.datePicked3)),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        final _datePicked4Time =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                              getCurrentTimestamp),
                                          builder: (context, child) {
                                            return wrapInMaterialTimePickerTheme(
                                              context,
                                              child!,
                                              headerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              headerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              headerTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 32.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                              pickerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              pickerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              selectedDateTimeBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              selectedDateTimeForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              actionButtonForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              iconSize: 24.0,
                                            );
                                          },
                                        );
                                        if (_datePicked4Time != null) {
                                          safeSetState(() {
                                            _model.datePicked4 = DateTime(
                                              getCurrentTimestamp.year,
                                              getCurrentTimestamp.month,
                                              getCurrentTimestamp.day,
                                              _datePicked4Time.hour,
                                              _datePicked4Time.minute,
                                            );
                                          });
                                        }
                                        FFAppState().updateAvailabilityAtIndex(
                                          1,
                                          (e) =>
                                              e..endTime = _model.datePicked4,
                                        );
                                        safeSetState(() {});
                                      },
                                      text: FFAppState()
                                                  .availability[1]
                                                  .endTime ==
                                              null
                                          ? 'End Time'
                                          : (FFAppState()
                                                  .availability[1]
                                                  .hasEndTime()
                                              ? dateTimeFormat(
                                                  "jm",
                                                  FFAppState()
                                                      .availability[1]
                                                      .endTime!)
                                              : dateTimeFormat(
                                                  "jm", _model.datePicked3)),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Wednesday',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {
                                        final _datePicked5Time =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                              getCurrentTimestamp),
                                          builder: (context, child) {
                                            return wrapInMaterialTimePickerTheme(
                                              context,
                                              child!,
                                              headerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              headerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              headerTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 32.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                              pickerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              pickerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              selectedDateTimeBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              selectedDateTimeForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              actionButtonForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              iconSize: 24.0,
                                            );
                                          },
                                        );
                                        if (_datePicked5Time != null) {
                                          safeSetState(() {
                                            _model.datePicked5 = DateTime(
                                              getCurrentTimestamp.year,
                                              getCurrentTimestamp.month,
                                              getCurrentTimestamp.day,
                                              _datePicked5Time.hour,
                                              _datePicked5Time.minute,
                                            );
                                          });
                                        }
                                        FFAppState().updateAvailabilityAtIndex(
                                          2,
                                          (e) =>
                                              e..startTime = _model.datePicked5,
                                        );
                                        safeSetState(() {});
                                      },
                                      text: FFAppState()
                                                  .availability[2]
                                                  .startTime ==
                                              null
                                          ? 'Start Time'
                                          : (FFAppState()
                                                  .availability[2]
                                                  .hasStartTime()
                                              ? dateTimeFormat(
                                                  "jm",
                                                  FFAppState()
                                                      .availability[2]
                                                      .startTime!)
                                              : dateTimeFormat(
                                                  "jm", _model.datePicked5)),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        final _datePicked6Time =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                              getCurrentTimestamp),
                                          builder: (context, child) {
                                            return wrapInMaterialTimePickerTheme(
                                              context,
                                              child!,
                                              headerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              headerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              headerTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 32.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                              pickerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              pickerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              selectedDateTimeBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              selectedDateTimeForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              actionButtonForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              iconSize: 24.0,
                                            );
                                          },
                                        );
                                        if (_datePicked6Time != null) {
                                          safeSetState(() {
                                            _model.datePicked6 = DateTime(
                                              getCurrentTimestamp.year,
                                              getCurrentTimestamp.month,
                                              getCurrentTimestamp.day,
                                              _datePicked6Time.hour,
                                              _datePicked6Time.minute,
                                            );
                                          });
                                        }
                                        FFAppState().updateAvailabilityAtIndex(
                                          2,
                                          (e) =>
                                              e..endTime = _model.datePicked6,
                                        );
                                        safeSetState(() {});
                                      },
                                      text: FFAppState()
                                                  .availability[2]
                                                  .endTime ==
                                              null
                                          ? 'End Time'
                                          : (FFAppState()
                                                  .availability[2]
                                                  .hasEndTime()
                                              ? dateTimeFormat(
                                                  "jm",
                                                  FFAppState()
                                                      .availability[2]
                                                      .endTime!)
                                              : dateTimeFormat(
                                                  "jm", _model.datePicked5)),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Thursday',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {
                                        final _datePicked7Time =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                              getCurrentTimestamp),
                                          builder: (context, child) {
                                            return wrapInMaterialTimePickerTheme(
                                              context,
                                              child!,
                                              headerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              headerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              headerTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 32.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                              pickerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              pickerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              selectedDateTimeBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              selectedDateTimeForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              actionButtonForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              iconSize: 24.0,
                                            );
                                          },
                                        );
                                        if (_datePicked7Time != null) {
                                          safeSetState(() {
                                            _model.datePicked7 = DateTime(
                                              getCurrentTimestamp.year,
                                              getCurrentTimestamp.month,
                                              getCurrentTimestamp.day,
                                              _datePicked7Time.hour,
                                              _datePicked7Time.minute,
                                            );
                                          });
                                        }
                                        FFAppState().updateAvailabilityAtIndex(
                                          3,
                                          (e) =>
                                              e..startTime = _model.datePicked7,
                                        );
                                        safeSetState(() {});
                                      },
                                      text: FFAppState()
                                                  .availability[3]
                                                  .startTime ==
                                              null
                                          ? 'Start Time'
                                          : (FFAppState()
                                                  .availability[3]
                                                  .hasStartTime()
                                              ? dateTimeFormat(
                                                  "jm",
                                                  FFAppState()
                                                      .availability[3]
                                                      .startTime!)
                                              : dateTimeFormat(
                                                  "jm", _model.datePicked7)),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        final _datePicked8Time =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                              getCurrentTimestamp),
                                          builder: (context, child) {
                                            return wrapInMaterialTimePickerTheme(
                                              context,
                                              child!,
                                              headerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              headerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              headerTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 32.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                              pickerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              pickerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              selectedDateTimeBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              selectedDateTimeForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              actionButtonForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              iconSize: 24.0,
                                            );
                                          },
                                        );
                                        if (_datePicked8Time != null) {
                                          safeSetState(() {
                                            _model.datePicked8 = DateTime(
                                              getCurrentTimestamp.year,
                                              getCurrentTimestamp.month,
                                              getCurrentTimestamp.day,
                                              _datePicked8Time.hour,
                                              _datePicked8Time.minute,
                                            );
                                          });
                                        }
                                        FFAppState().updateAvailabilityAtIndex(
                                          3,
                                          (e) =>
                                              e..endTime = _model.datePicked8,
                                        );
                                        safeSetState(() {});
                                      },
                                      text: FFAppState()
                                                  .availability[3]
                                                  .endTime ==
                                              null
                                          ? 'End Time'
                                          : (FFAppState()
                                                  .availability[3]
                                                  .hasEndTime()
                                              ? dateTimeFormat(
                                                  "jm",
                                                  FFAppState()
                                                      .availability[3]
                                                      .endTime!)
                                              : dateTimeFormat(
                                                  "jm", _model.datePicked7)),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Friday',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {
                                        final _datePicked9Time =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                              getCurrentTimestamp),
                                          builder: (context, child) {
                                            return wrapInMaterialTimePickerTheme(
                                              context,
                                              child!,
                                              headerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              headerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              headerTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 32.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                              pickerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              pickerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              selectedDateTimeBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              selectedDateTimeForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              actionButtonForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              iconSize: 24.0,
                                            );
                                          },
                                        );
                                        if (_datePicked9Time != null) {
                                          safeSetState(() {
                                            _model.datePicked9 = DateTime(
                                              getCurrentTimestamp.year,
                                              getCurrentTimestamp.month,
                                              getCurrentTimestamp.day,
                                              _datePicked9Time.hour,
                                              _datePicked9Time.minute,
                                            );
                                          });
                                        }
                                        FFAppState().updateAvailabilityAtIndex(
                                          4,
                                          (e) =>
                                              e..startTime = _model.datePicked9,
                                        );
                                        safeSetState(() {});
                                      },
                                      text: FFAppState()
                                                  .availability[4]
                                                  .startTime ==
                                              null
                                          ? 'Start Time'
                                          : (FFAppState()
                                                  .availability[4]
                                                  .hasStartTime()
                                              ? dateTimeFormat(
                                                  "jm",
                                                  FFAppState()
                                                      .availability[4]
                                                      .startTime!)
                                              : dateTimeFormat(
                                                  "jm", _model.datePicked9)),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        final _datePicked10Time =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                              getCurrentTimestamp),
                                          builder: (context, child) {
                                            return wrapInMaterialTimePickerTheme(
                                              context,
                                              child!,
                                              headerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              headerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              headerTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 32.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                              pickerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              pickerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              selectedDateTimeBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              selectedDateTimeForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              actionButtonForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              iconSize: 24.0,
                                            );
                                          },
                                        );
                                        if (_datePicked10Time != null) {
                                          safeSetState(() {
                                            _model.datePicked10 = DateTime(
                                              getCurrentTimestamp.year,
                                              getCurrentTimestamp.month,
                                              getCurrentTimestamp.day,
                                              _datePicked10Time.hour,
                                              _datePicked10Time.minute,
                                            );
                                          });
                                        }
                                        FFAppState().updateAvailabilityAtIndex(
                                          4,
                                          (e) =>
                                              e..endTime = _model.datePicked10,
                                        );
                                        safeSetState(() {});
                                      },
                                      text: FFAppState()
                                                  .availability[4]
                                                  .endTime ==
                                              null
                                          ? 'End Time'
                                          : (FFAppState()
                                                  .availability[4]
                                                  .hasEndTime()
                                              ? dateTimeFormat(
                                                  "jm",
                                                  FFAppState()
                                                      .availability[4]
                                                      .endTime!)
                                              : dateTimeFormat(
                                                  "jm", _model.datePicked9)),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Saturday',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {
                                        final _datePicked11Time =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                              getCurrentTimestamp),
                                          builder: (context, child) {
                                            return wrapInMaterialTimePickerTheme(
                                              context,
                                              child!,
                                              headerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              headerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              headerTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 32.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                              pickerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              pickerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              selectedDateTimeBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              selectedDateTimeForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              actionButtonForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              iconSize: 24.0,
                                            );
                                          },
                                        );
                                        if (_datePicked11Time != null) {
                                          safeSetState(() {
                                            _model.datePicked11 = DateTime(
                                              getCurrentTimestamp.year,
                                              getCurrentTimestamp.month,
                                              getCurrentTimestamp.day,
                                              _datePicked11Time.hour,
                                              _datePicked11Time.minute,
                                            );
                                          });
                                        }
                                        FFAppState().updateAvailabilityAtIndex(
                                          5,
                                          (e) => e
                                            ..startTime = _model.datePicked11,
                                        );
                                        safeSetState(() {});
                                      },
                                      text: FFAppState()
                                                  .availability[5]
                                                  .startTime ==
                                              null
                                          ? 'Start Time'
                                          : (FFAppState()
                                                  .availability[5]
                                                  .hasStartTime()
                                              ? dateTimeFormat(
                                                  "jm",
                                                  FFAppState()
                                                      .availability[5]
                                                      .startTime!)
                                              : dateTimeFormat(
                                                  "jm", _model.datePicked11)),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        final _datePicked12Time =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                              getCurrentTimestamp),
                                          builder: (context, child) {
                                            return wrapInMaterialTimePickerTheme(
                                              context,
                                              child!,
                                              headerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              headerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              headerTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 32.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                              pickerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              pickerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              selectedDateTimeBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              selectedDateTimeForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              actionButtonForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              iconSize: 24.0,
                                            );
                                          },
                                        );
                                        if (_datePicked12Time != null) {
                                          safeSetState(() {
                                            _model.datePicked12 = DateTime(
                                              getCurrentTimestamp.year,
                                              getCurrentTimestamp.month,
                                              getCurrentTimestamp.day,
                                              _datePicked12Time.hour,
                                              _datePicked12Time.minute,
                                            );
                                          });
                                        }
                                        FFAppState().updateAvailabilityAtIndex(
                                          5,
                                          (e) =>
                                              e..endTime = _model.datePicked12,
                                        );
                                        safeSetState(() {});
                                      },
                                      text: FFAppState()
                                                  .availability[5]
                                                  .endTime ==
                                              null
                                          ? 'End Time'
                                          : (FFAppState()
                                                  .availability[5]
                                                  .hasEndTime()
                                              ? dateTimeFormat(
                                                  "jm",
                                                  FFAppState()
                                                      .availability[5]
                                                      .endTime!)
                                              : dateTimeFormat(
                                                  "jm", _model.datePicked11)),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Inter',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Sunday',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      final _datePicked13Time =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(
                                            getCurrentTimestamp),
                                        builder: (context, child) {
                                          return wrapInMaterialTimePickerTheme(
                                            context,
                                            child!,
                                            headerBackgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            headerForegroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .info,
                                            headerTextStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineLarge
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      fontSize: 32.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                            pickerBackgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            pickerForegroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            selectedDateTimeBackgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            selectedDateTimeForegroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .info,
                                            actionButtonForegroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            iconSize: 24.0,
                                          );
                                        },
                                      );
                                      if (_datePicked13Time != null) {
                                        safeSetState(() {
                                          _model.datePicked13 = DateTime(
                                            getCurrentTimestamp.year,
                                            getCurrentTimestamp.month,
                                            getCurrentTimestamp.day,
                                            _datePicked13Time.hour,
                                            _datePicked13Time.minute,
                                          );
                                        });
                                      }
                                      FFAppState().updateAvailabilityAtIndex(
                                        6,
                                        (e) =>
                                            e..startTime = _model.datePicked13,
                                      );
                                      safeSetState(() {});
                                    },
                                    text: FFAppState()
                                                .availability[6]
                                                .startTime ==
                                            null
                                        ? 'Start Time'
                                        : (FFAppState()
                                                .availability[6]
                                                .hasStartTime()
                                            ? dateTimeFormat(
                                                "jm",
                                                FFAppState()
                                                    .availability[6]
                                                    .startTime!)
                                            : dateTimeFormat(
                                                "jm", _model.datePicked13)),
                                    options: FFButtonOptions(
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Inter',
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  FFButtonWidget(
                                    onPressed: () async {
                                      final _datePicked14Time =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(
                                            getCurrentTimestamp),
                                        builder: (context, child) {
                                          return wrapInMaterialTimePickerTheme(
                                            context,
                                            child!,
                                            headerBackgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            headerForegroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .info,
                                            headerTextStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineLarge
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      fontSize: 32.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                            pickerBackgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            pickerForegroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            selectedDateTimeBackgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            selectedDateTimeForegroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .info,
                                            actionButtonForegroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            iconSize: 24.0,
                                          );
                                        },
                                      );
                                      if (_datePicked14Time != null) {
                                        safeSetState(() {
                                          _model.datePicked14 = DateTime(
                                            getCurrentTimestamp.year,
                                            getCurrentTimestamp.month,
                                            getCurrentTimestamp.day,
                                            _datePicked14Time.hour,
                                            _datePicked14Time.minute,
                                          );
                                        });
                                      }
                                      FFAppState().updateAvailabilityAtIndex(
                                        6,
                                        (e) => e..endTime = _model.datePicked14,
                                      );
                                      safeSetState(() {});
                                    },
                                    text:
                                        FFAppState().availability[6].endTime ==
                                                null
                                            ? 'End Time'
                                            : (FFAppState()
                                                    .availability[6]
                                                    .hasEndTime()
                                                ? dateTimeFormat(
                                                    "jm",
                                                    FFAppState()
                                                        .availability[6]
                                                        .endTime!)
                                                : dateTimeFormat(
                                                    "jm", _model.datePicked13)),
                                    options: FFButtonOptions(
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Inter',
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 15.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              await manageBookingTimeBookingRecord.reference
                                  .update({
                                ...mapToFirestore(
                                  {
                                    'availability':
                                        getAvailabilityListFirestoreData(
                                      FFAppState().availability,
                                    ),
                                  },
                                ),
                              });

                              context.goNamed('BookingProfile');
                            },
                            text: 'Save',
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
