<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\Penjualan;
use Illuminate\Support\Facades\Http;

class PenjualanController extends Controller {
    public function store(Request $request) {
        $penjualan = Penjualan::create($request->all());
        return response()->json($penjualan, 201);
    }

    public function index() {
        return response()->json(Penjualan::all());
    }

    public function predict(Request $request) {
        $response = Http::post('http://127.0.0.1:5000/predict', [
            'harga' => $request->harga,
            'volume' => $request->volume
        ]);
        return $response->json();
    }
}
