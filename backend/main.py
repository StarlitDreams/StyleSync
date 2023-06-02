import openai
import csv

def read_api_key(filename):
    with open(filename, 'r') as file:
        api_key = file.readline().strip()  
    return api_key


openai.api_key  = read_api_key("api_key.txt")


        

messages = [
    {"role": "system", "content": "You are an intelligent clothing assistant. You shall create outfits from the clothes in the user's closet. \
    Output the outfit as a list of clothing items. Use a cheerful tone while describing the clothes."},
]

file_path =r'wardrobe.csv'

with open(file_path, 'r') as f:
    reader = csv.reader(f)

    for row in reader:
        row_string = ', '.join(row)
        messages.append({'role': "user", "content": row_string})

with open(file_path, 'r') as f:
    csv_string = f.read()

print(csv_string)


"""
message = input("User : ")
messages.append({"role": "user", "content": message},
                )
"""
chat = openai.ChatCompletion.create(
            model="gpt-3.5-turbo", messages=messages,temperature=1.3, max_tokens=150
        )
reply = chat.choices[0].message.content
print(f"Today's fit!!!! \n {reply}")
messages.append({"role": "assistant", "content": reply})


