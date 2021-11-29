import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/documents_view_contract.dart';
import 'package:gestint/models/document_model.dart';
import 'package:gestint/models/user.dart';
import 'package:gestint/presenters/documents_presenter.dart';
import 'package:provider/provider.dart';

import 'custom_progress_indicator.dart';

class DocumentsWidget extends StatefulWidget {
  const DocumentsWidget({Key? key}) : super(key: key);

  @override
  State<DocumentsWidget> createState() => _DocumentsWidgetState();
}

class _DocumentsWidgetState extends State<DocumentsWidget> implements DocumentsViewContract {

  late DocumentsPresenter _documentsPresenter;
  late List<Document> _documentsList;
  bool _isLoading = true;
  bool _documentsNotFound = false;

  @override
  void initState() {
    super.initState();
    _documentsPresenter = DocumentsPresenter(this);
    _documentsPresenter.getDocuments(Provider.of<User>(context, listen: false).getUserId());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: _isLoading ? CustomProgressIndicatorWidget() : _documentsNotFound? SizedBox.shrink() : ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: _documentsList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            trailing: IconButton(
              icon: Icon(
                Icons.download,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onPressed: () {
                //TODO download something
              },
            ),
            title: Text(
              _documentsList[index].title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
              //textAlign:TextAlign.end,
            ),
            subtitle: Text(
              'Fecha de efecto: ${_documentsList[index].date}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
              //textAlign:TextAlign.end,
            ),
            dense: false,
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  @override
  void onLoadDocumentsComplete(List<Document> documentsList) {
    setState(() {
      _documentsList = documentsList;
      _documentsNotFound = false;
      _isLoading = false;
    });
  }

  @override
  void onLoadDocumentsError() {
    setState(() {
      _isLoading = false;
      _documentsNotFound = true;
      _showErrorDialog();
    });
  }

  Future<void> _showErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atención'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text('Se ha producido un error al recuperar sus documentos'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Entendido'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}