import numpy as np
import tensorflow as tf
import joblib
from flask import Flask, request, jsonify
from pymongo import MongoClient

# Load model dan scaler
model = tf.keras.models.load_model("../models/lstm_model.h5")
scaler = joblib.load("../models/scaler.pkl")

# Setup Flask
app = Flask(__name__)

# Endpoint prediksi
@app.route("/predict", methods=["POST"])
def predict():
    data = request.json
    harga = data.get("harga")
    volume = data.get("volume")

    if harga is None or volume is None:
        return jsonify({"error": "Harap masukkan harga dan volume"}), 400

    # Normalisasi input
    input_data = scaler.transform([[harga, volume]])
    input_data = np.expand_dims(input_data, axis=0)

    # Prediksi
    pred = model.predict(input_data)
    pred = scaler.inverse_transform(pred)

    return jsonify({
        "predicted_harga": pred[0][0],
        "predicted_volume": pred[0][1]
    })

if __name__ == "__main__":
    app.run(debug=True, port=5000)
