import openai
import csv

def read_api_key(filename):
    with open(filename, 'r') as file:
        api_key = file.readline().strip()  
    return api_key


openai.api_key  = read_api_key("api_key.txt")


        

messages = [
    {
        "role": "system",
        "content": "You are an intelligent clothing assistant. You shall create outfits from the clothes in the user's closet. \
        Output the outfit as a list of clothing items. Use a cheerful tone while describing the clothes. \
        There are 3 main categories which are Tops, Bottoms, and accessories. \
        Make sure to include a top, a bottom, and an accessory if it fits well. \
        Make the outfit as fashionable as possible. \
        Make only 1 outfit suggestion. \
        The user will tell you their age, pronouns, and clothing preference. \
        The user will also tell you the clothes in their closet. \
        Print the outfit in a list.\
        Make the outfit appropriate and sensible."
    }
]

with open('biodata.txt', 'r') as file:
        lines = file.readlines()
        age = int(lines[0].strip())
        pronoun = lines[1].strip()
        preference = lines[2].strip()

messages.append({"role": "user", "content": "I am " + str(age) + " years old."})
messages.append({"role": "user", "content": "I Identify as " + pronoun + "."})
messages.append({"role": "user", "content": "I prefer " + preference + " clothing today."})


file_path =r'wardrobe.csv'

with open(file_path, 'r') as f:
    reader = csv.reader(f)

    for row in reader:
        row_string = ', '.join(row)
        messages.append({'role': "user", "content": row_string})


chat = openai.ChatCompletion.create(
            model="gpt-3.5-turbo", messages=messages,temperature=0.7, max_tokens=150
        )
reply = chat.choices[0].message.content

messages.append({"role": "assistant", "content": reply})

fit=open("fit.txt","w")
fit.write(reply)
fit.close()




