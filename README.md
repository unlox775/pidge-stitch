# Pidge Stitcher for ChatGPT Content

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

**Input**:

```json
[
    "Our tale begins in Quallaya, a city shimmering on the desert's horizon, its marble walls seemingly a mirage at first sight.  This grand city, home to the esteemed Quallaya Academy, also served as the residence of Braxion, the brass dragon who had commissioned the quest.  The adventurers arrived by magic portal, sidestepping the long and arduous journey across the desert that would otherwise be necessary.  As they emerged from the portal, the blazing sun transitioned to a more moderate temperature, making the city feel like a sanctuary.\n\n Guided through the lush gardens of the city, a fine mist sprayed from hidden mechanisms to cool them.  Soon, they found themselves walking through halls of pearly white marble.  Lecture halls, reading rooms, and tranquil gardens filled the academy, with faint music playing to set a peaceful atmosphere. ",
    " Attentive guards or attendants showed them to their quarters, ensuring they were well-acquainted with the academy before their meeting with Braxion.\n\n The adventurers, composed of Aric the Half-elf rogue, Key the human rogue, Taeral the shapeshifting monkey, and Aurelia the Kobold, were then ushered into the Grand Conversation Hall.  This plaza was flanked by tiered buildings and equipped with retractable shades for comfort, regardless of the time of day.  At its center lay a gazebo, and beneath its shade lounged Braxion.\n\n The brass dragon reclined comfortably on a satin pillow, his forearm adorned with intricate platinum bracelets embedded with an array of gems.  As Braxion concluded his previous conversation, the adventurers waited.  They had been closely guarded since their arrival, leading them to question the guards' purpose. \n\n\"Protect me or protect from me?\" Key couldn't help but murmur.\n\n\"From you, mostly,\" confirmed one of the guards, solidifying the atmosphere of caution that enveloped them.\n\n"
]
```

**Output**:

Our tale begins in Quallaya, a city shimmering on the desert's horizon, its marble walls seemingly a mirage at first sight.  This grand city, home to the esteemed Quallaya Academy, also served as the residence of Braxion, the brass dragon who had commissioned the quest.  The adventurers arrived by magic portal, sidestepping the long and arduous journey across the desert that would otherwise be necessary.  As they emerged from the portal, the blazing sun transitioned to a more moderate temperature, making the city feel like a sanctuary.

Guided through the lush gardens of the city, a fine mist sprayed from hidden mechanisms to cool them.  ***Soon, they found themselves walking through halls of pearly white marble.  Lecture halls, reading rooms, and tranquil gardens filled the academy, with faint music playing to set a peaceful atmosphere.   Attentive guards or attendants showed them to their quarters, ensuring they were well-acquainted with the academy before their meeting with Braxion.***

***The adventurers, composed of Aric the Half-elf rogue, Key the human rogue, Taeral the shapeshifting monkey, and Aurelia the Kobold, were then ushered into the Grand Conversation Hall.***  This plaza was flanked by tiered buildings and equipped with retractable shades for comfort, regardless of the time of day.  At its center lay a gazebo, and beneath its shade lounged Braxion.

The brass dragon reclined comfortably on a satin pillow, his forearm adorned with intricate platinum bracelets embedded with an array of gems.  As Braxion concluded his previous conversation, the adventurers waited.  They had been closely guarded since their arrival, leading them to question the guards' purpose. 

"Protect me or protect from me?" Key couldn't help but murmur.
