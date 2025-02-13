use App\Http\Controllers\PenjualanController;
Route::post('/penjualan', [PenjualanController::class, 'store']);
Route::get('/penjualan', [PenjualanController::class, 'index']);
Route::post('/predict', [PenjualanController::class, 'predict']);
