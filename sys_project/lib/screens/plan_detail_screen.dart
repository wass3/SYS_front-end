// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sys_project/models/plan.dart';
import 'package:sys_project/models/comments.dart';
import 'package:sys_project/service/comment_service.dart';
import 'package:sys_project/service/user_service.dart'; // Import the UserService

class PlanDetailPage extends StatefulWidget {
  final Plan plan;

  const PlanDetailPage({Key? key, required this.plan}) : super(key: key);

  @override
  _PlanDetailPageState createState() => _PlanDetailPageState();
}

class _PlanDetailPageState extends State<PlanDetailPage> {
  late Future<List<Comment>> _futureComments;

  @override
  void initState() {
    super.initState();
    _futureComments = CommentService.getCommentsByPlanId(widget.plan.planId);
  }

  Future<String> _getUsername(String userId) async {
    final user = await UserService.getUserById(userId);
    return user.userHandler;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff050d09),
      appBar: AppBar(
        title: Text(widget.plan.title, style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff050d09),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.plan.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              'Lugar: ${widget.plan.place}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 8),
            if (widget.plan.dayhour != null)
              Text(
                'Fecha y Hora: ${DateFormat('dd/MM/yyyy – kk:mm').format(widget.plan.dayhour!)}',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            const SizedBox(height: 16),
            Text(
              'Estado: ${widget.plan.state}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              'Detalles adicionales del plan...',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Divider(color: Colors.white),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.auto_awesome_outlined, color: Color(0xff97e2ba)),
                SizedBox(width: 4),
                Text(
                  'Memories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 4),
                Icon(Icons.auto_awesome_outlined, color: Color(0xff97e2ba)),
              ],
            ),
            const SizedBox(height: 4),
            Divider(color: Colors.white),
            const SizedBox(height: 8),
            Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 2.0,
                  color: Color(0xcc35e789),
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FutureBuilder<List<Comment>>(
                          future: _futureComments,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Failed to load comments', style: TextStyle(color: Colors.white)));
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(child: Text('No comments available', style: TextStyle(color: Colors.white)));
                            } else {
                              final comments = snapshot.data!;
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  final comment = comments[index];
                                  return FutureBuilder<String>(
                                    future: _getUsername('${comment.userId}'),
                                    builder: (context, userSnapshot) {
                                      if (userSnapshot.connectionState == ConnectionState.waiting) {
                                        return Center(child: CircularProgressIndicator());
                                      } else if (userSnapshot.hasError) {
                                        return Center(child: Text('Failed to load username', style: TextStyle(color: Colors.white)));
                                      } else {
                                        final username = userSnapshot.data!;
                                        return Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                username,
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(comment.text ?? '', style: TextStyle(color: Colors.white)),
                                                  if (comment.commentImg != null) ...[
                                                    SizedBox(height: 14),
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(12.0),
                                                      child: Image.network('https://www.feet9.com/cam/wp-content/uploads/2019/02/Outing-with-friends-1024x683.jpeg'),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                            Divider(color: Color(0x44ffffff)),
                                          ],
                                        );
                                      }
                                    },
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}
