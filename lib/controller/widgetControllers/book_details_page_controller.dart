import 'package:historium/controller/outputModels/StoryDetailsOutput.dart';

class BookDetailsPageController {
	Future<StoryDetailsOutput> loadStoryInfo(String id) async {
		final storyOutput = StoryDetailsOutput();

		storyOutput.title = 'A revolução dos bixos';
		storyOutput.authorName = 'George Orwell';
		storyOutput.coverUrl = 'https://images-na.ssl-images-amazon.com/images/I/81D0qNDMqPL.jpg';
		storyOutput.genres = [
      "Romance",
      "Ação",
      "Scifi",
      "Bibliografia",
      "Horror",
      "Fantasia",
      "Suspence",
      "Classico",
    ];
		storyOutput.summary = 'Uns animal vai lá e faz oque a população brasileira não fez em uns 500 anos de história';

		return Future.value(storyOutput);
	}
}