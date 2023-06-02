import openai

openai.api_key = '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'

messages = [
    {"role": "system", "content": "You are an intelligent clothing assistant. You shall create outfits from the clothes in the user's closet. \
    Output the outfit as a list of clothing items. Use a cheerful tone while describing the clothes."},
]





message = input("User : ")
messages.append({"role": "user", "content": message},
                )
chat = openai.ChatCompletion.create(
            model="gpt-3.5-turbo", messages=messages,temperature=1.3, max_tokens=150
        )
reply = chat.choices[0].message.content
print(f"ChatGPT: {reply}")
messages.append({"role": "assistant", "content": reply})