// class RecipeRepositoryImpl extends RecipeRepository {
//   final RecipeApiService _recipeApiService;

//   RecipeRepositoryImpl(this._recipeApiService);

//   @override
//   Future<DataState<List<RecipeModel>>> getRecipe() async {
//     try {
//       final httpResponse = await _recipeApiService.getRecipe();

//       if (httpResponse.response.statusCode == HttpStatus.ok) {
//         return DataSuccess(httpResponse.data);
//       } else {
//         return DataException(DioException(
//           error: httpResponse.response.statusMessage,
//           response: httpResponse.response,
//           type: DioExceptionType.badResponse,
//           requestOptions: httpResponse.response.requestOptions,
//         ));
//       }
//     } on DioException catch (exception) {
//       return DataException(exception);
//     }
//   }
// }
