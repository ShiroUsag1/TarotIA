import os
from flask import Flask, jsonify, request
import openai
from pymongo import MongoClient
from pymongo.server_api import ServerApi
from openai import OpenAI
from urllib.parse import quote_plus
from flask_cors import CORS


username = os.getenv("username")
password = os.getenv("password")
url_db = os.getenv("mongo_db_url")

username_escaped = quote_plus(username)
password_escaped = quote_plus(password)

app = Flask(__name__)
CORS(app)

uri = f"mongodb+srv://{username_escaped}:{password_escaped}@{url_db}"
client = MongoClient(uri, server_api=ServerApi("1"))
db = client["tarot_database"]
cartas_collection = db["cartas"]
cartas = []
api_key = os.getenv("OPENAI_API_KEY")
openai_client = OpenAI(api_key=api_key)


@app.route("/interpretar", methods=["POST"])
def interpretar():
    try:
        data = request.get_json()
        cartas = data.get("cartas", [])
        simbolismos = []
        for carta in cartas:
            documento = cartas_collection.find_one({"nome": carta})
            if documento:
                simbolismo = documento.get("simbolismo", [])
                if isinstance(simbolismo, list):
                    # Junte os elementos da lista em uma string
                    simbolismo = ", ".join(simbolismo)
                simbolismos.append(simbolismo)
            else:
                return jsonify({"error": f"Carta '{carta}' não encontrada."}), 404

        prompt = f"As cartas tiradas foram {', '.join(cartas)}. Os significados são {', '.join(simbolismos)}. Qual seria a interpretação geral dessa tirada?"

        # response = openai_client.chat.completions.create(
        #     messages=[
        #         {
        #             "role": "user",
        #             "content": prompt,
        #         }
        #     ],
        #     model="gpt-3.5-turbo",
        # )

        # interpretacao = response.choices[0].message['content']

        return jsonify({"interpretacao": prompt})

    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
