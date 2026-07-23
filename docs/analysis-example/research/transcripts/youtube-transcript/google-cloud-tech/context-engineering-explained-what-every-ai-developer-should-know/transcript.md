---
title: "Context engineering explained: What every AI developer should know"
channel: Google Cloud Tech
date: 2026-07-15
url: "https://www.youtube.com/watch?v=BBPQYtR7oUk"
cover: imgs/cover.jpg
description: "White-paper on context engineering → https://goo.gle/3QiKYbT  More info on context engineering → https://goo.gle/43fII8c"
language: en
---

# Context engineering explained: What every AI developer should know

White-paper on context engineering → https://goo.gle/3QiKYbT  More info on context engineering → https://goo.gle/43fII8c

## Table of Contents

* [00:00:00] - Bigger prompts don't fix bad AI
* [00:00:47] - What is context engineering?
* [00:01:39] - Why context size isn't everything
* [00:02:18] - Four failure modes: Poisoning, distraction, confusion, clash
* [00:02:58] - Context engineering vs prompt engineering
* [00:04:16] - The seven components of a context stack
* [00:05:02] - Building LogLook: A realistic agent example
* [00:07:00] - The 4 steps of context engineering
* [00:07:08] - Step 1: Write
* [00:07:50] - Step 2: Select
* [00:08:34] - Step 3: Compress
* [00:09:14] - Step 4: Isolate
* [00:09:50] - Curate, don't dump


![cover](imgs/cover.jpg)

## [00:00:00] - Bigger prompts don't fix bad AI

[music] >> Most people try to fix bad AI answers by writing bigger prompts. That's the wrong move. If you have been padding prompts like an essay to make your model give you better answers, then stick around. In a few minutes, you'll learn how to use context engineering in a simple way to make your AI systems smarter and way more reliable. By the end of this video, you'll know exactly what context engineering is, why it's different from just prompting, and a step-by-step way to use it on real projects. [00:00:03 → 00:00:39]

We'll road test it on a tiny but realistic agent, show you where context usually fall apart, and give you a checklist on how to fix them really fast. [00:00:39 → 00:00:49]


## [00:00:47] - What is context engineering?

Context engineering is the craft of deciding exactly what the model should see and what it shouldn't at each step. It includes your system message, tools, retrieved facts, short-term notes, long-term memories, format rules, and also recent history. If prompt engineering is how you word the ask, then context engineering is everything you feed the model so it can actually do the job. This is a huge shift that AI teams across the industry are calling out, where we are moving from perfect prompts to curating the smallest set of high-signal tokens that steer the behavior of your model into the right direction, especially in agents that run for many turns and use tools. [00:00:49 → 00:01:41]


## [00:01:39] - Why context size isn't everything

So now context is being treated like a scarce working memory, and AI developers are looking at it differently. Why does this matter? So models keep getting larger context windows, but longer context isn't always better. When you fill up that window, accuracy often drops because errors sneak in and the model gets distracted by stale or irrelevant text or two pieces of context which actually quietly contradict each other. This shows up most in agents where the conversation and tools output snowballs. [00:01:41 → 00:02:18]


## [00:02:18] - Four failure modes: Poisoning, distraction, confusion, clash

So, you'll see four common failure modes in the wild. First off, we have poisoning where a hallucinated fact gets into context and is reused over and over again. Second, we have something called distraction where the model fixates on a huge history instead of making a fresh plan. Third is confusion where extra unrelated details nudge it into the wrong answer. And fourth is clash where two sources disagree and the model picks the wrong one. [00:02:18 → 00:02:53]

So, why am I mentioning this? Because knowing these names can help you fix what is wrong. Next, we need to talk about what the difference is between context engineering versus prompt engineering. [00:02:53 → 00:03:07]


## [00:02:58] - Context engineering vs prompt engineering

So, prompt engineering is how you write and structure instructions, examples, and constraints. It's still very relevant and useful, but context engineering is how you assemble everything that model will see at run time like the right tools, the right facts, the right history, and the right format. It's dynamic and happens before every model call, so it's pretty powerful. Think of the model like a brain with a limited short-term memory. Your job is to pack it with all the things that it needs for the next step and you have limited space to do so. [00:03:04 → 00:03:44]

Here is what is in a context stack currently for most models that we use. There are seven pieces involved. First, we have instructions which are the system prompt and guardrails. Clear and plain language wins here. Second, we have user input, which is the current ask from the user. [00:03:41 → 00:04:04]

Third, we have retrieved facts, which are the few snippets that matter the most. Fourth, we have tools, which are functions that the model can call, as well as their descriptions, which are part of the context. [00:04:04 → 00:04:19]


## [00:04:16] - The seven components of a context stack

Fifth, we have short-term notes, which summarizes all the recent steps, so that the model remembers what has changed recently. Sixth, we have long-term memory, which contains stable facts about the user or project, selected on demand. And lastly, we have output format, which are schemas or examples that lock the shape of the answer. Now, let's dive into a single example. Let's build a simple agent called Log Look, which is a helper that triages security alerts when they occur, and drafts a one-paragraph summary of the alert, plus a severity score of how severe the alert is. [00:04:16 → 00:05:03]


## [00:05:02] - Building LogLook: A realistic agent example

The chatbot way is to say, "Hey, here you go. Analyze today's logs and tell me what's wrong. " It might actually just spit out random guesses at that point. But with context engineering, we feed Log Look, our agent, a clean plate of the following things. First, we give system instructions, like summarize incidents into one paragraph, plus a severity score between 0 and 4. [00:05:03 → 00:05:31]

Only use provided context, and if missing data exist, ask for a specific file path. Second, we will list tools that it requires in order to answer the questions that we ask it. So, for example, reading file, or grep, or get known false positives. Third, we provide retrieved facts which only contain today's log slice and only lines with error or critical from the last hour will be sent to our agent. And also, the team's false positive list for noisy alerts is something that we'll also flag to our agent. [00:05:28 → 00:06:07]

The fourth thing that we're going to be passing to our agent is short-term notes. So, we've already checked this file. Next, scan this log instead. And then, we're also going to be giving it a format. We want it to expect JSON formats input and output. [00:06:07 → 00:06:27]

So, that's the difference. Same model, but with way better context. Now, let's talk about the four steps of context engineering. These show up across the best agent systems and they're really simple to remember. Write, select, compress, and isolate. [00:06:27 → 00:06:47]

First, we have write, which means to save notes outside of the context window. This actually lets the agent keep a scratch pad which contains plans, intermediate results, and open questions. It also makes sure that we don't squeeze all of that into the next call, but instead keep it external and only pull from it when it's relevant. [00:06:45 → 00:07:10]


## [00:07:00] - The 4 steps of context engineering


## [00:07:08] - Step 1: Write

This keeps the working context clean while preserving memory. So, for our agent log look, we can store all of that into something called investigation steps. md, which will contain a bulleted list of what's been checked. Second step is select, which means pull only what matters right now. So, use retrieval to fetch just the log slices and policy lines needed for this turn. [00:07:10 → 00:07:40]

Hybrid retrieval, which contains both keyword and semantics, often beats embedding only search on messy logs. The point is selection and not hoarding. [00:07:40 → 00:07:52]


## [00:07:50] - Step 2: Select

So if our agent log look, we'll be selecting the top end number of error bursts and the specific section on severity scoring from our runbook. At third step, we have compress, which means keep the signal but drop the rest. What we need to do is periodically summarize long histories into short loss aware notes and then continue with a fresh window. So this keeps the last few raw items for safety, but then it also beats dragging a huge chat history everywhere. So for log look, we'll be keeping the last five findings, but everything older will be rolled into a three-line recap. [00:07:50 → 00:08:36]


## [00:08:34] - Step 3: Compress

The fourth and final step is isolate, which means sandbox sources to avoid cross talk. We can do this by splitting big jobs into sub agents or phases. Each explores its own context and then returns a short digest to a coordinator. This reduces leakage between tools and prevents one noisy source from poisoning the rest. So for our agent log look, a reader sub agent just extracts the facts and then a scorer sub agent applies the policy, while a writer sub agent composes the final summary from their digest. [00:08:34 → 00:09:14]


## [00:09:14] - Step 4: Isolate

If you remember one thing from all of this, it's really important to curate instead of dumping a large chunk of prompts. Context engineering isn't just a buzzword, it's a natural progression of prompt engineering. It's a discipline of building robust, reliable, and truly useful applications. It's how we move from simple chatbots to complex AI [music] agents that can become our collaborators. Hope you found this video helpful and hope you've learned how context engineering actually [music] works and how it differs from something like prompt engineering. [00:09:14 → 00:09:51]


## [00:09:50] - Curate, don't dump
