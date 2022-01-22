import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/image_input.dart';
import '../custom_widgets/location_input.dart';
import '../providers/great_places.dart';
import '../models/place.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 1.35,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                        controller: _titleController,
                      ),
                      ImageInput(_selectImage),
                      LocationInput(_selectPlace),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: Icon(
              Icons.add,
              size: 25,
            ),
            label: Text(
              'Add Place',
              style: TextStyle(fontSize: 18),
            ),
            onPressed: _savePlace,
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize:
                    MaterialStateProperty.all(Size(double.infinity, 55))),
            // elevation: 0,
            // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
