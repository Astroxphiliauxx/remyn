import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/icon_provider.dart';


class IconPicker {
  static void showIconPicker(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconProvider = Provider.of<IconProvider>(context, listen: false);
    final List<IconData> icons = [
      Icons.access_alarm, Icons.access_time, Icons.accessibility, Icons.account_balance,
      Icons.account_circle, Icons.add, Icons.airplanemode_active, Icons.alarm,
      Icons.album, Icons.anchor, Icons.android, Icons.apartment, Icons.archive,
      Icons.arrow_back, Icons.arrow_forward, Icons.article, Icons.assessment,
      Icons.assignment, Icons.assistant, Icons.attach_file, Icons.attach_money,
      Icons.audiotrack, Icons.autorenew, Icons.av_timer, Icons.backpack,
      Icons.backspace, Icons.bar_chart, Icons.bathtub, Icons.beach_access,
      Icons.bedtime, Icons.bike_scooter, Icons.biotech, Icons.block, Icons.bolt,
      Icons.book, Icons.bookmark, Icons.bookmarks, Icons.brightness_5,
      Icons.brightness_6, Icons.broken_image, Icons.brush, Icons.bubble_chart,
      Icons.bug_report, Icons.build, Icons.business, Icons.cached, Icons.cake,
      Icons.calendar_today, Icons.call, Icons.camera, Icons.camera_alt,
      Icons.cancel, Icons.car_rental, Icons.card_giftcard, Icons.card_membership,
      Icons.card_travel, Icons.cast, Icons.category, Icons.chat, Icons.check,
      Icons.check_circle, Icons.checklist, Icons.chevron_left, Icons.chevron_right,
      Icons.circle, Icons.clear, Icons.close, Icons.cloud, Icons.cloud_download,
      Icons.cloud_upload, Icons.code, Icons.comment, Icons.compare, Icons.computer,
      Icons.contact_mail, Icons.contact_phone, Icons.content_copy, Icons.content_cut,
      Icons.content_paste, Icons.control_camera, Icons.copy, Icons.create,
      Icons.credit_card, Icons.dashboard, Icons.date_range, Icons.delete,
      Icons.delete_forever, Icons.delivery_dining, Icons.description, Icons.desktop_mac,
      Icons.device_hub, Icons.devices, Icons.dialpad, Icons.directions,
      Icons.directions_bike, Icons.directions_bus, Icons.directions_car,
      Icons.directions_walk, Icons.disabled_by_default, Icons.disc_full,
      Icons.dns, Icons.done, Icons.done_all, Icons.download, Icons.drafts,
      Icons.drag_handle, Icons.drive_eta, Icons.dvr, Icons.dynamic_feed,
      Icons.eco, Icons.edit, Icons.eject, Icons.email, Icons.emoji_emotions,
      Icons.error, Icons.event, Icons.expand_less, Icons.expand_more,
      Icons.explore, Icons.extension, Icons.face, Icons.favorite, Icons.feedback,
      Icons.file_download, Icons.file_upload, Icons.filter_alt, Icons.find_in_page,
      Icons.find_replace, Icons.fingerprint, Icons.flag, Icons.flash_on,
      Icons.flight, Icons.folder, Icons.forum, Icons.functions, Icons.g_translate,
      Icons.gamepad, Icons.gavel, Icons.gesture, Icons.get_app, Icons.gps_fixed,
      Icons.grade, Icons.group, Icons.hail, Icons.handyman, Icons.hdr_strong,
      Icons.headset, Icons.hearing, Icons.height, Icons.help, Icons.highlight,
      Icons.history, Icons.home, Icons.hourglass_empty, Icons.http, Icons.https,
      Icons.image, Icons.import_contacts, Icons.info, Icons.insert_chart,
      Icons.insert_drive_file, Icons.inventory, Icons.key, Icons.label,
      Icons.language, Icons.laptop, Icons.last_page, Icons.launch, Icons.layers,
      Icons.leak_add, Icons.library_add, Icons.lightbulb, Icons.link,
      Icons.list, Icons.location_on, Icons.lock, Icons.lock_open,
      Icons.loyalty, Icons.mail, Icons.map, Icons.mark_email_read, Icons.menu,
      Icons.message, Icons.mic, Icons.military_tech, Icons.mode_comment,
      Icons.money, Icons.mood, Icons.movie, Icons.music_note, Icons.nature,
      Icons.network_wifi, Icons.new_releases, Icons.next_week, Icons.nightlight,
      Icons.notifications, Icons.notifications_active, Icons.offline_bolt,
      Icons.palette, Icons.pan_tool, Icons.pause, Icons.payment, Icons.people,
      Icons.person, Icons.phone, Icons.photo, Icons.picture_as_pdf,
      Icons.place, Icons.play_arrow, Icons.play_circle_fill, Icons.poll,
      Icons.print, Icons.public, Icons.radio, Icons.record_voice_over,
      Icons.redeem, Icons.refresh, Icons.remove, Icons.reorder, Icons.reply,
      Icons.report, Icons.room, Icons.router, Icons.save, Icons.schedule,
      Icons.school, Icons.search, Icons.send, Icons.settings, Icons.share,
      Icons.shop, Icons.shopping_bag, Icons.shopping_cart, Icons.signal_cellular_4_bar,
      Icons.sim_card, Icons.speaker, Icons.star, Icons.storage, Icons.store,
      Icons.style, Icons.sync, Icons.tag_faces, Icons.terrain, Icons.text_fields,
      Icons.thumb_up, Icons.timer, Icons.today, Icons.toggle_on, Icons.translate,
      Icons.trending_up, Icons.verified, Icons.video_call, Icons.view_agenda,
      Icons.volume_up, Icons.warning, Icons.wifi, Icons.work
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 800,
          child: GridView.builder(
            itemCount: icons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 8,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  iconProvider.changeIcon(icons[index]);
                  Navigator.pop(context);
                },
                child: Icon(icons[index], size: 28, color: colorScheme.onSurface),
              );
            },
          ),
        );
      },
    );
  }
}
