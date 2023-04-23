/// # Type and constant definitions for all parts of the app

import 'package:flutter/material.dart';

const String VERSION = '0.0.1';

const double defaultMainMenuIconSize = 72;

// The icons of the main sections
const String iconSports = "assets/sports_running.png";

// Options for return values of the storage operations routine of TheBox
enum ModelLoadState { present, encrypted, nonexistent, failed }

// Options for screens to show after boot
enum BoxNextApp { mainApp, failure, onboarding }
