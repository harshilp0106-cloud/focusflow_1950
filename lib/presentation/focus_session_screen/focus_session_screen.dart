import 'package:flutter/material.dart';

import '../../widgets/app_bar_widget.dart';
import './widgets/app_blocking_widget.dart';
import './widgets/duration_picker_widget.dart';
import './widgets/session_launch_button_widget.dart';
import './widgets/session_type_selector_widget.dart';

class FocusSessionScreen extends StatefulWidget {
  const FocusSessionScreen({super.key});

  @override
  State<FocusSessionScreen> createState() => _FocusSessionScreenState();
  // TODO: Replace with [Riverpod/Bloc] for production session state
}

class _FocusSessionScreenState extends State<FocusSessionScreen> {
  String _selectedType = 'Deep Work';
  int _durationMinutes = 25;
  bool _appBlockingEnabled = true;
  bool _strictModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0F),
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: _FocusAppBar(),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 80 + MediaQuery.of(context).padding.top + 16,
            bottom: 120,
            left: isTablet ? 32 : 16,
            right: isTablet ? 32 : 16,
          ),
          child: isTablet ? _buildTabletLayout() : _buildPhoneLayout(),
        ),
      ),
      floatingActionButton: null,
      bottomSheet: SessionLaunchButtonWidget(
        sessionType: _selectedType,
        durationMinutes: _durationMinutes,
      ),
    );
  }

  Widget _buildPhoneLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SessionTypeSelectorWidget(
          selected: _selectedType,
          onSelected: (t) => setState(() => _selectedType = t),
        ),
        const SizedBox(height: 20),
        DurationPickerWidget(
          minutes: _durationMinutes,
          onChanged: (m) => setState(() => _durationMinutes = m),
        ),
        const SizedBox(height: 20),
        AppBlockingWidget(
          blockingEnabled: _appBlockingEnabled,
          strictModeEnabled: _strictModeEnabled,
          onBlockingToggle: (v) => setState(() => _appBlockingEnabled = v),
          onStrictToggle: (v) => setState(() => _strictModeEnabled = v),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              SessionTypeSelectorWidget(
                selected: _selectedType,
                onSelected: (t) => setState(() => _selectedType = t),
              ),
              const SizedBox(height: 20),
              DurationPickerWidget(
                minutes: _durationMinutes,
                onChanged: (m) => setState(() => _durationMinutes = m),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: AppBlockingWidget(
            blockingEnabled: _appBlockingEnabled,
            strictModeEnabled: _strictModeEnabled,
            onBlockingToggle: (v) => setState(() => _appBlockingEnabled = v),
            onStrictToggle: (v) => setState(() => _strictModeEnabled = v),
          ),
        ),
      ],
    );
  }
}

class _FocusAppBar extends StatelessWidget {
  const _FocusAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      title: 'Focus Session',
      subtitle: 'Configure your deep work session',
      isItalic: false,
      showBell: false,
    );
  }
}
