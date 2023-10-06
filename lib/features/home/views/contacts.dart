import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speso_chatapp/shared/models/user.dart';
import 'package:speso_chatapp/shared/widgets/search.dart';
import 'package:speso_chatapp/theme/theme.dart';

import '../../../shared/models/contact.dart';

class ChatAppContactsList extends StatelessWidget {
  final User user;

  final List<Contact> contactsOnChatApp;

  final WidgetRef ref;
  const ChatAppContactsList({
    Key? key,
    required this.user,
    required this.contactsOnChatApp,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var contact in contactsOnChatApp)
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    backgroundImage: CachedNetworkImageProvider(
                      contact.avatarUrl!,
                    ),
                  ),
                  const SizedBox(
                    width: 18.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(contact.displayName,
                          style: Theme.of(context).custom.textTheme.bold),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        'Hey there! I\'m using ChatApp.',
                        style: Theme.of(context).custom.textTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class ContactsPage extends ConsumerStatefulWidget {
  final User user;
  const ContactsPage({super.key, required this.user});

  @override
  ConsumerState<ContactsPage> createState() => _ContactsPageState();
}

class LocalContactsList extends StatelessWidget {
  final List<Contact> contactsNotOnChatApp;

  final WidgetRef ref;
  const LocalContactsList({
    Key? key,
    required this.contactsNotOnChatApp,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var contact in contactsNotOnChatApp)
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.black,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  const SizedBox(
                    width: 18.0,
                  ),
                  Text(
                    contact.displayName,
                    style: Theme.of(context).custom.textTheme.bold,
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: double.infinity,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'INVITE',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color:
                              Theme.of(context).custom.colorTheme.greenColor),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _ContactsPageState extends ConsumerState<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).custom.colorTheme;

    return ScaffoldWithSearch(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Select contact'),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          const Text(''),
          PopupMenuButton(
            onSelected: (value) {},
            color: colorTheme.appBarColor,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.more_vert),
            ),
            itemBuilder: (context) {
              TextStyle popupMenuTextStyle = Theme.of(context)
                  .custom
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white);
              return <PopupMenuEntry>[
                PopupMenuItem(
                    onTap: () {},
                    child: Text(
                      'Invite a friend',
                      style: Theme.of(context)
                          .custom
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.white),
                    )),
                PopupMenuItem(
                    onTap: null,
                    child: Text(
                      'Contacts',
                      style: Theme.of(context)
                          .custom
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.white),
                    )),
                PopupMenuItem(
                    onTap: () {},
                    child: Text(
                      'Refresh',
                      style: Theme.of(context)
                          .custom
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.white),
                    )),
                PopupMenuItem(
                    onTap: null,
                    child: Text(
                      'Help',
                      style: popupMenuTextStyle,
                    )),
              ];
            },
          ),
        ],
      ),
      searchController: TextEditingController(text: ""),
      onChanged: (value) => null,
      onCloseBtnPressed: () => null,
      searchIconActionIndex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: colorTheme.greenColor,
                          child: const Icon(
                            Icons.people,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 18.0,
                        ),
                        Text(
                          'New group',
                          style: Theme.of(context).custom.textTheme.bold,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: colorTheme.greenColor,
                          child: const Icon(
                            Icons.person_add,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 18.0,
                        ),
                        Text('New contact',
                            style: Theme.of(context).custom.textTheme.bold),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              child: Text(
                'More',
                style: Theme.of(context).custom.textTheme.caption,
              ),
            ),
            Column(
              children: [
                InkWell(
                  onTap: null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: colorTheme.appBarColor,
                          child: Icon(
                            Icons.person_add,
                            color: colorTheme.iconColor,
                          ),
                        ),
                        const SizedBox(
                          width: 18.0,
                        ),
                        Text('New Contact',
                            style: Theme.of(context).custom.textTheme.bold),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: colorTheme.appBarColor,
                          child: Icon(
                            Icons.share,
                            color: colorTheme.iconColor,
                          ),
                        ),
                        const SizedBox(
                          width: 18.0,
                        ),
                        Text('Share invite link',
                            style: Theme.of(context).custom.textTheme.bold),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: colorTheme.appBarColor,
                          child: Icon(
                            Icons.question_mark,
                            color: colorTheme.iconColor,
                          ),
                        ),
                        const SizedBox(
                          width: 18.0,
                        ),
                        Text('Contacts help',
                            style: Theme.of(context).custom.textTheme.bold),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _buildChatAppContactsList(
    BuildContext context,
    List<Contact> contactsOnChatApp,
  ) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ),
        child: Text(
          'Contacts on ChatApp',
          style: Theme.of(context).custom.textTheme.caption,
        ),
      ),
      ChatAppContactsList(
        user: widget.user,
        contactsOnChatApp: contactsOnChatApp,
        ref: ref,
      )
    ];
  }

  List<Widget> _buildLocalContactsList(
    BuildContext context,
    List<Contact> contactsNotOnChatApp,
  ) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ),
        child: Text(
          'Invite ',
          style: Theme.of(context).custom.textTheme.caption,
        ),
      ),
      LocalContactsList(
        contactsNotOnChatApp: contactsNotOnChatApp,
        ref: ref,
      ),
    ];
  }
}
