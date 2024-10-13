import os
from flask import Flask, jsonify, request
import openai
from pymongo import MongoClient
from pymongo.server_api import ServerApi
from openai import OpenAI
from urllib.parse import quote_plus
from flask_cors import CORS
from models import Carta


username = os.getenv("USERNAME")
password = os.getenv("PASSWORD")
url_db = os.getenv("MONGO_DB_URL")

username_escaped = quote_plus(username)
password_escaped = quote_plus(password)

app = Flask(__name__)
CORS(app)

uri = f"mongodb+srv://{username_escaped}:{password_escaped}@{url_db}"
client = MongoClient(uri, server_api=ServerApi("1"))
db = client["tarot_database"]
cartas_collection = db["cartas"]


api_key = os.getenv("OPENAI_API_KEY")
openai_client = OpenAI(api_key=api_key)


app = Flask(__name__)

@app.route('/cartas', methods=['GET'])
def get_cartas():
    try:
        cartas = []
        for carta in cartas_collection.find():
            cartas.append({
                "nome": carta.get('nome', 'Nome não encontrado'),
                "descricao": carta.get('descricao', 'Descrição não encontrada'),
                "imagem_url": carta.get('imagem_url', 'URL da imagem não encontrada'),
                "tipo": carta.get('tipo', 'Tipo não encontrado'),
                "naipe": carta.get('naipe', 'Naipe não encontrado'),
                "numero": carta.get('numero', 'Número não encontrado'),
                "simbolismo": carta.get('simbolismo', ['Simbolismo não encontrado']),
                "inversao": carta.get('inversao', 'Inversão não encontrada')
            })
        return jsonify(cartas)
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    
    
# @app.route("/interpretar", methods=["POST"])
# def interpretar():
#     try:
#         data = request.get_json()
#         cartas = data.get("cartas", [])
#         simbolismos = []
#         for carta in cartas:
#             documento = cartas_collection.find_one({"nome": carta})
#             if documento:
#                 simbolismo = documento.get("simbolismo", [])
#                 if isinstance(simbolismo, list):
#                     # Junte os elementos da lista em uma string
#                     simbolismo = ", ".join(simbolismo)
#                 simbolismos.append(simbolismo)
#             else:
#                 return jsonify({"error": f"Carta '{carta}' não encontrada."}), 404

#         prompt = f"As cartas tiradas foram {', '.join(cartas)}. Os significados são {', '.join(simbolismos)}. Qual seria a interpretação geral dessa tirada?"

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

    #     return jsonify({"interpretacao": prompt})

    # except Exception as e:
    #     return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
