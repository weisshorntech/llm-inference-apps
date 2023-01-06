import openai


def davinci_completion(prompt):
    """_summary_

    Args:
        prompt (_type_): _description_

    Returns:
        _type_: _description_
    """
    return openai.Completion.create(
        model="text-davinci-002",
        prompt=prompt,
        temperature=0.7,
        max_tokens=256,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0,
    )
