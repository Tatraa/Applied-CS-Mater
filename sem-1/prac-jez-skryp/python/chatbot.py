import os
from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError
from flask import Flask, request, Response

app = Flask(__name__)

client = WebClient(token=os.environ['SLACK_BOT_TOKEN'])

# Przykładowe dane konfiguracyjne
config = {
    "hours": "We are open from 9 AM to 9 PM every day.",
    "menu": ["pizza", "pasta", "salads"]
}

orders = {}

def handle_message(event_data):
    message = event_data['event']
    user_id = message['user']
    if 'text' in message:
        text = message['text'].lower()
        if 'hello' in text or 'hi' in text or 'hey' in text:
            send_message(message['channel'], "Hello! How can I help you today?")
        elif 'hours' in text or 'open' in text:
            send_message(message['channel'], config["hours"])
        elif 'menu' in text or 'food' in text:
            send_message(message['channel'], f"Our menu includes: {', '.join(config['menu'])}.")
        elif 'order' in text:
            orders[user_id] = {"items": [], "address": ""}
            send_message(message['channel'], "What would you like to order?")
        elif user_id in orders and not orders[user_id]["items"]:
            items = [item.strip() for item in text.split(',')]
            orders[user_id]["items"] = items
            send_message(message['channel'], "Please provide your delivery address.")
        elif user_id in orders and orders[user_id]["items"] and not orders[user_id]["address"]:
            orders[user_id]["address"] = text
            send_message(message['channel'], f"Thank you! Your order for {', '.join(orders[user_id]['items'])} will be delivered to {orders[user_id]['address']} within 30 minutes.")
        else:
            send_message(message['channel'], "I'm sorry, I didn't understand that. Can you please rephrase?")

def send_message(channel, text):
    try:
        response = client.chat_postMessage(channel=channel, text=text)
    except SlackApiError as e:
        print(f"Error sending message: {e.response['error']}")

@app.route('/slack/events', methods=['POST'])
def slack_events():
    event_data = request.json
    if 'event' in event_data:
        handle_message(event_data)
    return Response(status=200)

if __name__ == "__main__":
    app.run(port=3000)