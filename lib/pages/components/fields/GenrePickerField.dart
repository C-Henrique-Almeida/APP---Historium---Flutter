import 'package:flutter/material.dart';
import 'package:historium/model/helpers/BookGenreHelper.dart';

class GenrePickerField extends StatefulWidget {
	final GenrePickerFieldController controller;
	final hintText;

	GenrePickerField({
		this.controller,
		this.hintText
	});

	@override
	_GenrePickerFieldState createState() => _GenrePickerFieldState();
}

class _GenrePickerFieldState extends State<GenrePickerField> {

	final textController = TextEditingController();

	GenrePickerFieldController controller;

	void updateField() => textController.text = controller.value.join(', ');

	@override
  void initState() {
    super.initState();

		controller = widget.controller ?? GenrePickerFieldController();
		controller.addListener(updateField);


		textController.text = controller.value.join(', ');
	}

	@override
	Widget build(BuildContext context) {
		return TextFormField(
      readOnly: true,
      onTap: () => showDialog(
				context: context,
				builder: (BuildContext _context) => buildGenrePickerPanel()
			),
      decoration: InputDecoration(
        hintText: widget.hintText ?? 'Gêneros',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))
        )
      ),
      controller: textController,
      validator: (String value) {
        if(value.isEmpty) {
          return 'Esse campo deve ser preenchido';
        } 
        return null;
      }
    );
	}

	Widget buildGenrePickerPanel() {
		return Scaffold(
			persistentFooterButtons: [
				Flex(
					direction: Axis.horizontal,
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						TextButton(
							onPressed: () => Navigator.pop(context), 
							child: Text("Ok"),
						)
					],  
				)
			],
			appBar: AppBar(
				backgroundColor: Colors.black,
				title: Text("Selecione seus generos favoritos"),
			),
			body: ListView.separated(
				itemCount: controller.allGenres.length,

				separatorBuilder: (_context, index) =>
				SizedBox(height: 20,),

				itemBuilder: (_context, index) => 
				StatefulBuilder(
					builder: (context, setDialogState) {
						String genre = controller.allGenres[index];

						return Container(
							height: 50,
							padding: EdgeInsets.symmetric(horizontal: 10),
							child: ElevatedButton(
								style: ButtonStyle(
									elevation: MaterialStateProperty.all(
										10
									),
									backgroundColor: MaterialStateProperty.all(
										controller.isGenreInTheList(genre) ?
											Colors.black : Colors.white,
									),
									textStyle: MaterialStateProperty.all(TextStyle(
										color:  controller.isGenreInTheList(genre)?
											Colors.black : Colors.white,
									)),
									shape: MaterialStateProperty.all(
										RoundedRectangleBorder(
											borderRadius: BorderRadius.circular(30)
										)
									)
								),
								onPressed: () {
									setDialogState(() => controller.toggleGenre(genre));
								},
								child: Text(
									controller.allGenres[index],
									style: TextStyle(
										fontSize: 20,
										color: controller.isGenreInTheList(genre) ?
											Colors.white : Colors.black,
									),
								),
							),
						);
					}
					
				),
			),
		);
	}	
}

class GenrePickerFieldController extends ValueNotifier<List<String>> {
	GenrePickerFieldController({List<String> initialGenres})
	: super(initialGenres ?? []);

	get allGenres => BookGenreHelper().listAll();

	set genres(List<String> genres) {
		super.value = genres;
		notifyListeners();
	}

	get genres => super.value;

	bool isGenreInTheList(String genre) => super.value.contains(genre);

	void toggleGenre(String genre) {
		if(super.value.contains(genre)) super.value.remove(genre);
		else super.value.add(genre);

		notifyListeners();
	}
}