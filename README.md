# Pidge-based Stitcher for AI Multi-Message Content

## Overview
The Pidge Stitcher is designed specifically for handling and refining the output from generative AIs like ChatGPT. It aims to stitch together a series of AI-generated content messages by removing redundant preambles and conclusions in consecutive AI messages, thereby producing a more cohesive story.

## Problem Statement
ChatGPT, as with many generative AIs, often adds a "preamble" at the start of its messages, such as setting up the scene or a prefix like "Okay, certainly I'd love to help with that." These AI messages also conclude with summaries or endings, like "I hope you found this helpful."  When generating a story across multiple messages, these repetitive beginnings and ends disrupt the flow of the story, as an artifact of the AI's output constraints.

## Solution
The Pidge Stitcher addresses this by blending and stitching messages together. It segments each message into thirds (top, middle, bottom) and then merges the last third of a message with the first third of the subsequent message, aiming to create a smoother transition and a unified body of content.  This also shortens the messages a little as the preambles and conclusions are removed.

## How it Works

1. **Segmentation**: Each AI message is divided into thirds - top, middle, and bottom.  It does this by attempting to split by sentence
2. **Stitching**: The app feeds the AI these pieces of two consecutive messages (e.g. message A and B):
   - the middle third of message A (for context only)
   - the last third of the message A
   - the first third of message B
   - middle third of message B (for context only)
3. **Merging**: The primary objective is to merge the conclusion of one message (found in its last third) with the preamble of the subsequent message (found in its initial third). The Stitcher identifies common conclusion and preamble terms, understanding the story's direction, and creates a seamless body of text that replaces the end of one message and the beginning of the next, with a new blended transition text.
4. **Output**: The stitched story feels more cohesive, providing an improved reading experience.  It then continues through all the elements of the JSON.  At the very end, it outputs the stitched story to a file named `final_stitched.txt`

**NOTE**: Because it only blends each pair of adjacent messages, it will not remove the preamble at the top of your first mesage, nor the conclusion at the bottom of your last message.  You can remove these manually if you wish.

## Usage

### Prerequisites

- Ensure you have Pidge installed. If not, [find it here](https://github.com/unlox775/project-roe).

### Input

1. Prepare your input as a valid JSON array: an open square bracket followed by strings separated by commas. Example:

```json
["First message here.", "Second message.", "Third message..."]
```

2. This array represents the individual AI message bodies.

### Running the App

1. Pipe your input file into the Pidge Stitcher's first runtime:

```bash
cat your_input_file.json | pidge go --session mystory1
```

2. Upon completion, the app will generate `output.txt` containing the stitched content.

## Example

### Input:

```json
[
    "Certainly, I'll revise the story to fit the specific feedback you've provided. Here's the edited version:\n\n=====================\nOur tale begins in Quallaya, a city shimmering on the desert's horizon, its marble walls seemingly a mirage at first sight. This grand city, home to the esteemed Quallaya Academy, also served as the residence of Braxion, the brass dragon who had commissioned the quest. The adventurers arrived by magic portal, sidestepping the long and arduous journey across the desert that would otherwise be necessary. As they emerged from the portal, the blazing sun transitioned to a more moderate temperature, making the city feel like a sanctuary.\n\nGuided through the lush gardens of the city, a fine mist sprayed from hidden mechanisms to cool them. Soon, they found themselves walking through halls of pearly white marble. Lecture halls, reading rooms, and tranquil gardens filled the academy, with faint music playing to set a peaceful atmosphere. Attentive guards or attendants showed them to their quarters, ensuring they were well-acquainted with the academy before their meeting with Braxion.\n\nThe adventurers, composed of Aric the Half-elf rogue, Key the human rogue, Taeral the shapeshifting monkey, and Aurelia the Kobold, were then ushered into the Grand Conversation Hall. This plaza was flanked by tiered buildings and equipped with retractable shades for comfort, regardless of the time of day. At its center lay a gazebo, and beneath its shade lounged Braxion.\n\nThe brass dragon reclined comfortably on a satin pillow, his forearm adorned with intricate platinum bracelets embedded with an array of gems. As Braxion concluded his previous conversation, the adventurers waited. They had been closely guarded since their arrival, leading them to question the guards' purpose. \n\n\"Protect me or protect from me?\" Key couldn't help but murmur.\n\n\"From you, mostly,\" confirmed one of the guards, solidifying the atmosphere of caution that enveloped them.\n\nFinally, they were invited to approach Braxion, whose gaze focused intently on them.\n\n\"Ah, welcome, welcome, my adventurers. I am very pleased that you've all gathered here to meet me,\" the brass dragon greeted, his voice tinged with both authority and warmth.\n\nAnd so, in the heart of Quallaya, under the watchful eye of a brass dragon, our adventurers prepared to embark on a quest that would likely shape not just their own lives, but the very world itself.\n=====================\n\nI've made sure to include all the characters, corrected the city name to \"Quallaya,\" and clarified that it was Key who wondered about the guards' intentions, with a guard confirming that they were mostly there to protect others from him. Feel free to copy and paste this revised version into your story.",
    "Certainly! Based on your feedback, I've made the necessary adjustments to the story for consistency and clarity. Here's the revised part:\n\n=====================\nBraxion, the brass dragon who had commissioned this quest, perched on a raised platform within the central gazebo of the Grand Conversation Hall. The majestic creature's eyes glimmered with intelligence as it surveyed the adventurers assembled before it. The Hall, part of the esteemed Quallaya Academy, was bathed in the golden light of the late afternoon sun, its retractable shades pulled back to let in the warmth.\n\n\"Aurelia, my favorite ally—a long-standing symbol of my alliance for the Lambdas. You're one of my most loyal servants, and I'm glad you're here to help me in this matter,\" Braxion began, struggling a bit with his articulation as if he wasn't used to speaking in this particular form. \n\nHe then turned his gaze toward Aric. \"Your family has long been my ally. I'm glad you've taken the steps to be here. I think this endeavor will benefit both of us greatly.\"\n\nBraxion’s eyes shifted to Key. \"And Key, your expertise will be most useful. Your reputation precedes you. I do hope the guards haven't made your stay too unpleasant.\"\n\n\"Eh, it's been pretty fine,\" Key responded, casually flicking a finger toward the attendant guards. \"I wish these guys would get off my back, but I get that's probably not going to happen.\"\n\n\"Perhaps not,\" Braxion conceded, \"but it's all for the best—just precautions. Let's move on to more productive matters.\"\n\nFinally, Braxion's gaze settled on Taeral, who was currently in the shape of a monkey, idly picking at some fruits laid out on a table. \"Taeral, you've been here for a while, and we could really use your expertise on this mission. It requires someone who’s been around and understands the lay of the land.\"\n\n\"We are gathered here,\" Braxion paused, taking a moment to focus, \"because of the Varian Lex. Nearly 800 years ago, this artifact was destroyed when the Varian Empire fell. Its pages were scattered and have been impossible to locate until now. A friend, who wishes to remain anonymous, has given us leads on its whereabouts. We've sent agents to recover these pages, but they've faced difficulties. That's where you all come in.\"\n\nHe leaned closer, emphasizing his next words. \"The Varian Lex is a historical treasure. Its recovery will benefit not only us but also our allies. You are precisely the team to help us finally recover these lost pages.\"\n\nBraxion seemed to catch his breath for a moment before laying out the financial terms. \"Key, for your efforts, we are offering ten platinum pieces per page recovered.\"\n\nA mumble of approval ran through the adventurers. \"Yes? Sounds doable,\" one said, although it was unclear who.\n\n\"What about any other treasure?\" another inquired.\n\n\"I assume this will be quite the adventure,\" a third added.\n\nBraxion nodded. \"You're allowed to keep whatever items you find, which should be additional incentive. Is that agreeable?\"\n\nA murmur of consensus filled the air. \n\nBraxion concluded, \"Key is the professionally hired hand here. The rest of you are participating either out of loyalty or direct interest in the Academy. I believe this arrangement benefits us all.\"\n\n\"So, it's ten platinum pieces just for Key, per page?\" one of the adventurers asked for clarification, still slightly unsure.\n\n\"Correct,\" Braxion confirmed, \"and given your various skill sets and motivations, I don't foresee this being a problem for such a capable team.\"\n\nAnd so, with the terms agreed upon and the mission laid out, the adventurers prepared themselves for what would surely be a journey full of risk, discovery, and the promise of untold rewards. Braxion watched them, pleased; if anyone could recover the lost pages of the Varian Lex, it would be this eclectic but highly skilled group.\n=====================\n\nYou can copy-paste this version directly into your ongoing story. Would you like me to update your JSON object again with new information from this part of the story?"
]
```

Here it is in a more readable format.  The portion of the text that gets merged is in bold italics.

####  First mesasge from AI:

> Certainly, I'll revise the story to fit the specific feedback you've provided. Here's the edited version:
> 
> `=====================`
> 
> Our tale begins in Quallaya, a city shimmering on the desert's horizon, its marble walls seemingly a mirage at first sight. This grand city, home to the esteemed Quallaya Academy, also served as the residence of Braxion, the brass dragon who had commissioned the quest. The adventurers arrived by magic portal, sidestepping the long and arduous journey across the desert that would otherwise be necessary. As they emerged from the portal, the blazing sun transitioned to a more moderate temperature, making the city feel like a sanctuary.
> 
> Guided through the lush gardens of the city, a fine mist sprayed from hidden mechanisms to cool them. Soon, they found themselves walking through halls of pearly white marble. Lecture halls, reading rooms, and tranquil gardens filled the academy, with faint music playing to set a peaceful atmosphere. Attentive guards or attendants showed them to their quarters, ensuring they were well-acquainted with the academy before their meeting with Braxion.
> 
> The adventurers, composed of Aric the Half-elf rogue, Key the human rogue, Taeral the shapeshifting monkey, and Aurelia the Kobold, were then ushered into the Grand Conversation Hall. This plaza was flanked by tiered buildings and equipped with retractable shades for comfort, regardless of the time of day. At its center lay a gazebo, and beneath its shade lounged Braxion.
> 
> The brass dragon reclined comfortably on a satin pillow, his forearm adorned with intricate platinum bracelets embedded with an array of gems. As Braxion concluded his previous conversation, the adventurers waited. They had been closely guarded since their arrival, leading them to question the guards' purpose. 
> 
> "Protect me or protect from me?" Key couldn't help but murmur.
> 
> "From you, mostly," confirmed one of the guards, solidifying the atmosphere of caution that enveloped them.
> 
> $\text{\color{red}Finally, they were invited to approach Braxion, whose gaze focused intently on them.}$
> 
> $\text{\color{red}"Ah, welcome, welcome, my adventurers. I am very pleased that you've all gathered here to meet me," the brass dragon greeted, his voice tinged with both authority and warmth.}$
> 
> $\text{\color{red}And so, in the heart of Quallaya, under the watchful eye of a brass dragon, our adventurers prepared to embark on a quest that would likely shape not just their own lives, but the very world itself.}$
> 
> `=====================`
> 
> $\text{\color{red}I've made sure to include all the characters, corrected the city name to "Quallaya," and clarified that it was Key who wondered about the guards' intentions, with a guard confirming that they were mostly there to protect others from him. Feel free to copy and paste this revised version into your story.}$

####  Second message from AI:

> $\text{\color{red}Certainly! Based on your feedback, I've made the necessary adjustments to the story for consistency and clarity. Here's the revised part:}$
> 
> `=====================`
> 
> $\text{\color{red}Braxion, the brass dragon who had commissioned this quest, perched on a raised platform within the central gazebo of the Grand Conversation Hall. The majestic creature's eyes glimmered with intelligence as it surveyed the adventurers assembled before it. The Hall, part of the esteemed Quallaya Academy, was bathed in the golden light of the late afternoon sun, its retractable shades pulled back to let in the warmth.}$
> 
> $\text{\color{red}"Aurelia, my favorite ally—a long-standing symbol of my alliance for the Lambdas. You're one of my most loyal servants, and I'm glad you're here to help me in this matter," Braxion began, struggling a bit with his articulation as if he wasn't used to speaking in this particular form.}$
> 
> $\text{\color{red}He then turned his gaze toward Aric. "Your family has long been my ally. I'm glad you've taken the steps to be here. I think this endeavor will benefit both of us greatly."}$
> 
> $\text{\color{red}Braxion’s eyes shifted to Key. "And Key, your expertise will be most useful. Your reputation precedes you. I do hope the guards haven't made your stay too unpleasant."}$
> 
> $\text{\color{red}"Eh, it's been pretty fine," Key responded, casually flicking a finger toward the attendant guards. "I wish these guys would get off my back, but I get that's probably not going to happen."}$
> 
> $\text{\color{red}"Perhaps not," Braxion conceded, "but it's all for the best—just precautions.}$ Let's move on to more productive matters."
> 
> Finally, Braxion's gaze settled on Taeral, who was currently in the shape of a monkey, idly picking at some fruits laid out on a table. "Taeral, you've been here for a while, and we could really use your expertise on this mission. It requires someone who’s been around and understands the lay of the land."
> 
> "We are gathered here," Braxion paused, taking a moment to focus, "because of the Varian Lex. Nearly 800 years ago, this artifact was destroyed when the Varian Empire fell. Its pages were scattered and have been impossible to locate until now. A friend, who wishes to remain anonymous, has given us leads on its whereabouts. We've sent agents to recover these pages, but they've faced difficulties. That's where you all come in."
> 
> He leaned closer, emphasizing his next words. "The Varian Lex is a historical treasure. Its recovery will benefit not only us but also our allies. You are precisely the team to help us finally recover these lost pages."
> 
> Braxion seemed to catch his breath for a moment before laying out the financial terms. "Key, for your efforts, we are offering ten platinum pieces per page recovered."
> 
> A mumble of approval ran through the adventurers. "Yes? Sounds doable," one said, although it was unclear who.
> 
> "What about any other treasure?" another inquired.
> 
> "I assume this will be quite the adventure," a third added.
> 
> Braxion nodded. "You're allowed to keep whatever items you find, which should be additional incentive. Is that agreeable?"
> 
> A murmur of consensus filled the air. 
> 
> Braxion concluded, "Key is the professionally hired hand here. The rest of you are participating either out of loyalty or direct interest in the Academy. I believe this arrangement benefits us all."
> 
> "So, it's ten platinum pieces just for Key, per page?" one of the adventurers asked for clarification, still slightly unsure.
> 
> "Correct," Braxion confirmed, "and given your various skill sets and motivations, I don't foresee this being a problem for such a capable team."
> 
> And so, with the terms agreed upon and the mission laid out, the adventurers prepared themselves for what would surely be a journey full of risk, discovery, and the promise of untold rewards. Braxion watched them, pleased; if anyone could recover the lost pages of the Varian Lex, it would be this eclectic but highly skilled group.
> 
> `=====================`
> 
> You can copy-paste this version directly into your ongoing story. Would you like me to update your JSON object again with new information from this part of the story?

### Output:

> Certainly, I'll revise the story to fit the specific feedback you've provided. Here's the edited version:
> 
> `=====================`
> 
> Our tale begins in Quallaya, a city shimmering on the desert's horizon, its marble walls seemingly a mirage at first sight.  This grand city, home to the esteemed Quallaya Academy, also served as the residence of Braxion, the brass dragon who had commissioned the quest.  The adventurers arrived by magic portal, sidestepping the long and arduous journey across the desert that would otherwise be necessary.  As they emerged from the portal, the blazing sun transitioned to a more moderate temperature, making the city feel like a sanctuary.
> 
> Guided through the lush gardens of the city, a fine mist sprayed from hidden mechanisms to cool them.  Soon, they found themselves walking through halls of pearly white marble.  Lecture halls, reading rooms, and tranquil gardens filled the academy, with faint music playing to set a peaceful atmosphere.   Attentive guards or attendants showed them to their quarters, ensuring they were well-acquainted with the academy before their meeting with Braxion.
> 
> The adventurers, composed of Aric the Half-elf rogue, Key the human rogue, Taeral the shapeshifting monkey, and Aurelia the Kobold, were then ushered into the Grand Conversation Hall.  This plaza was flanked by tiered buildings and equipped with retractable shades for comfort, regardless of the time of day.  At its center lay a gazebo, and beneath its shade lounged Braxion.
> 
> The brass dragon reclined comfortably on a satin pillow, his forearm adorned with intricate platinum bracelets embedded with an array of gems.  As Braxion concluded his previous conversation, the adventurers waited.  They had been closely guarded since their arrival, leading them to question the guards' purpose. 
> 
> "Protect me or protect from me?" Key couldn't help but murmur.
> 
> "From you, mostly," confirmed one of the guards, solidifying the atmosphere of caution that enveloped them.
> 
> $\text{\color{red}Finally, they were invited to approach Braxion, whose gaze focused intently on them.}$
> 
> $\text{\color{red}"Ah, welcome, welcome, my adventurers. I am very pleased that you've all gathered here to meet me," the brass dragon greeted, his voice tinged with both authority and warmth.}$
> 
> $\text{\color{red}"Aurelia, my favorite ally—a long-standing symbol of my alliance for the Lambdas. You're one of my most loyal servants, and I'm glad you're here to help me in this matter," Braxion began, struggling a bit with his articulation as if he wasn't used to speaking in this particular form.}$
> 
> $\text{\color{red}He then turned his gaze toward Aric. "Your family has long been my ally. I'm glad you've taken the steps to be here. I think this endeavor will benefit both of us greatly."}$
> 
> $\text{\color{red}Braxion’s eyes shifted to Key. "And Key, your expertise will be most useful. Your reputation precedes you. I do hope the guards haven't made your stay too unpleasant."}$
> 
> $\text{\color{red}"Eh, it's been pretty fine," Key responded, casually flicking a finger toward the attendant guards. "I wish these guys would get off my back, but I get that's probably not going to happen."}$
> 
> $\text{\color{red}"Perhaps not," Braxion conceded, "but it's all for the best—just precautions."}$  Let's move on to more productive matters."
> 
> Finally, Braxion's gaze settled on Taeral, who was currently in the shape of a monkey, idly picking at some fruits laid out on a table. "Taeral, you've been here for a while, and we could really use your expertise on this mission. It requires someone who’s been around and understands the lay of the land."
> 
> "We are gathered here," Braxion paused, taking a moment to focus, "because of the Varian Lex. Nearly 800 years ago, this artifact was destroyed when the Varian Empire fell. Its pages were scattered and have been impossible to locate until now. A friend, who wishes to remain anonymous, has given us leads on its whereabouts. We've sent agents to recover these pages, but they've faced difficulties. That's where you all come in."
> 
> He leaned closer, emphasizing his next words. "The Varian Lex is a historical treasure. Its recovery will benefit not only us but also our allies. You are precisely the team to help us finally recover these lost pages."
> 
> Braxion seemed to catch his breath for a moment before laying out the financial terms. "Key, for your efforts, we are offering ten platinum pieces per page recovered."
> 
> A mumble of approval ran through the adventurers. "Yes? Sounds doable," one said, although it was unclear who.
> 
> "What about any other treasure?" another inquired.
> 
> "I assume this will be quite the adventure," a third added.
> 
> Braxion nodded. "You're allowed to keep whatever items you find, which should be additional incentive. Is that agreeable?"
> 
> A murmur of consensus filled the air. 
> 
> Braxion concluded, "Key is the professionally hired hand here. The rest of you are participating either out of loyalty or direct interest in the Academy. I believe this arrangement benefits us all."
> 
> "So, it's ten platinum pieces just for Key, per page?" one of the adventurers asked for clarification, still slightly unsure.
> 
> "Correct," Braxion confirmed, "and given your various skill sets and motivations, I don't foresee this being a problem for such a capable team."
> 
> And so, with the terms agreed upon and the mission laid out, the adventurers prepared themselves for what would surely be a journey full of risk, discovery, and the promise of untold rewards. Braxion watched them, pleased; if anyone could recover the lost pages of the Varian Lex, it would be this eclectic but highly skilled group.
> 
> `=====================`
> 
> You can copy-paste this version directly into your ongoing story. Would you like me to update your JSON object again with new information from this part of the story?