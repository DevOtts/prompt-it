---
title: "Fable 5 And GPT-5.6 Don't Need Better Prompts. They Need A Clean Setup."
channel: "AI News & Strategy Daily | Nate B Jones"
date: 2026-07-15
url: "https://www.youtube.com/watch?v=PDJfciNhyHU"
cover: imgs/cover.jpg
description: "Full post w/ Clean Your Harness Guide: https://natesnewsletter.substack.com/p/ai-harness-audit?r=1z4sm5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true"
language: en
---

# Fable 5 And GPT-5.6 Don't Need Better Prompts. They Need A Clean Setup.

Full post w/ Clean Your Harness Guide: https://natesnewsletter.substack.com/p/ai-harness-audit?r=1z4sm5&utm_campaign=post&utm_medium=web&showWelcomeOnShare=true

## Table of Contents

* [00:00:00] I Overbuilt My AI Harness
* [00:01:58] The Hidden Cost of Harness Bloat
* [00:04:54] Rule 2: Blame the Right Layer
* [00:06:06] Rule 3: One Rule, One Home, One Owner
* [00:07:27] Rule 4: Load It When You Need It
* [00:08:25] Rule 5: Hard Rules Need Hard Checks
* [00:08:58] Rule 6: Build for the Model and Product
* [00:10:58] The Codex Audit Results
* [00:12:17] Fable 5 vs. ChatGPT 5.6 Failure Modes
* [00:12:54] A Clean Harness Without the Barnacles
* [00:14:17] Own the System Around Your AI
* [00:14:39] The Cleaner Skill


![cover](imgs/cover.jpg)

## [00:00:00] I Overbuilt My AI Harness

I overbuilt my harness for Fable 5 and Chat GPT 5. 6 and I did it before they came out. I was so excited. I've been using AI a lot. I've been adding new rules and new instructions and new skills and I've been enthusiastic and you know what that means? [00:00:00 → 00:00:14]

It means my everything around it, all of the skills, all of the old system prompts, all of that was bloat that kept my AI models from performing well. Every time my AI missed something, I added another rule. A lot of us do, right? I would tell it use these sources correctly or write in my voice or check the length in this way or read this file first. Never make this mistake again. [00:00:14 → 00:00:35]

Make no mistakes, right? Every rule ended up fixing a real problem at the time, but over time, I didn't realize how bloated my harness had become. If you don't know what a harness is, that's part of the problem, too, because we haven't been clear about that as a community. A harness is everything wrapped around the model. So, it's your custom instructions. [00:00:35 → 00:00:58]

It's your project files. It's your saved prompts. It's your memory. Your your skills, your tools. It's your permissions, any checks that you run, right? [00:00:58 → 00:01:06]

It shapes the answer before you type anything into the prompt window because it comes with that prompt and helps the model understand what to respond with. Most of us never set out to build a harness. We built it accidentally, one correction at a time. I had no screen that showed me the full extent of the harness I built in Codex and Claude. I could see the latest rule I added if I looked for it, but I couldn't see the whole system in one place. [00:01:06 → 00:01:31]

When the AI started behaving strangely, I would often blame the model and I know a lot of people do and then I would add another rule and that would make it even more bloated, right? So, I built a skill that makes the harness visible. I'll show you six principles for building a more stable harness, including what works differently for Fable 5 and the Chat GPT 5. 6 family of models. Then we'll show you how you can run the same cleaner on your setup. [00:01:29 → 00:01:55]

The goal is very simple. The models keep evolving, right? And that's not going to change. [00:01:55 → 00:02:00]


## [00:01:58] The Hidden Cost of Harness Bloat

Now, when I ran the first inventory on my setup, it found 66 reusable skills and 172 instruction-related files. I've been very busy. One normal writing job could pull in an 18,000-word file before it even adjusted the prompt. But, the number wasn't the real problem. Some of those instructions actually protect really important work. [00:02:00 → 00:02:19]

They tell the AI which sources matter when I'm doing research. They stop it from inventing an opinion that I genuinely don't have. I don't like it when it does that. They define what it can do without asking me and what it needs to ask me about. Problem was, I couldn't tell with the new intelligence, the new models, which rules were protecting the work and which were just copies or overlaps or arriving too early or unnecessary with today's models or or overlapping in a way that was confusing to the model. [00:02:19 → 00:02:48]

It's like everything around the engine in the car all the way to what makes the wheels go, right? The drive shaft is an example. The the full chassis. All of the parts of a car that are not the engine that are required to transfer force from the engine to the wheels. That's what a harness is for an AI model. [00:02:48 → 00:03:05]

It actually makes the work possible and we should definitely design it intentionally and not just guess and throw bolts into the car. The thing is, when the model changes, the harness doesn't magically rebuild itself. Sometimes you choose the new model. Sometimes ChatGPT or Claude will actually change your default for you and retire an older model and it will route a a difficult request somewhere new. And sometimes it will even switch models in the middle of the conversation. [00:03:05 → 00:03:31]

You may not even know it happened, right? And the old setup, the old harness, the old chassis for that car stays in place. The new model may behave very, very differently as a result and you may wonder why. You may blame the model, right? The experience could get worse. [00:03:29 → 00:03:43]

So, you add another instruction. I pointed at the setup I already use and I ask it to clean the harness that it can see. I don't gather every prompt by hand. I don't decide what should be deleted before it starts. The skill begins by making a map of my harness. [00:03:43 → 00:03:59]

That leads to the first rule, right? You map the harness before you clean it. It's actually a principle, right? The skill does it, but it's because it's a good idea. The map gives every important control that you have in your harness a separate row and asks, "Where does this control live? [00:03:57 → 00:04:12]

When does it load? What job does it do? Who owns this? Is there any evidence that it still helps? What problem can it create if it's misused? [00:04:12 → 00:04:23]

" And this was the first time I saw my whole harness in one place. And I don't know about you, but that's It was really illuminating how much junk there was there. It also exposed a difference that chat bots normally hides. Other controls are actual locks. They have teeth to them, right? [00:04:23 → 00:04:38]

A permission can block an action, a schema can reject a broken JSON file, a task can refuse a bad result if it fails. Those are not the same kind of instruction, right? Until you map the harness, it can all look like text to you, but it doesn't read the same way to an AI. [00:04:38 → 00:04:55]


## [00:04:54] Rule 2: Blame the Right Layer

The second principle that I learned as I built this is to blame the right layer. Uh I tested the same underlying job with Fable 5 in two different setups. The compact setup gave Fable the goal, the facts, the permission boundary that I had for it, and the finish line. The thicker setup, the thicker skill, gave it all of that plus the full method, plus a scoring system, an eval plan, and classification scheme. And the thicker version did do the job more completely. [00:04:55 → 00:05:26]

The analysis that I got was much richer, but it also failed actual delivery requirements twice. One result broke the JSON, another broke the word limit. The compact setup finished correctly three times out of three. Like all three times it finished right. That doesn't mean that short prompts always win. [00:05:23 → 00:05:43]

I want to be clear about that. It means that the model and the harness produce the work that we care about together. If you blame the model for everything, you will keep adding instructions to solve problems created by instructions, not by the model. And so, the cleaner skill force is a much more useful question for all of us. Did the model fail or did the surrounding setup fail? [00:05:43 → 00:06:05]

Right? Did the harness fail? [00:06:04 → 00:06:07]


## [00:06:06] Rule 3: One Rule, One Home, One Owner

Let's jump to the third. The third rule is one rule, one home, one owner. Right? It's easy to remember. My setup had versions of the same authorship and source rule in 15 different top-level skills, indicating I cared about it a lot, but I was not getting traction or progress in any of the individual skills, so I kept working on it. [00:06:07 → 00:06:26]

For me, the critical thing that I care about is that I don't want AI putting words in my mouth. I don't want it to come back with research and pretend it's my opinion. And so, I have 15 different versions of a skill that stops AI from reading a pile of research and coming back in my voice, because I really, really care about understanding exactly what was researched and getting the citation correct. So, I want to keep that quality, but I sure don't need 15 different files pretending to do that once, and clearly none of them quite did it right because I kept adding to it. Every copy is another place where the rule can drift. [00:06:26 → 00:07:00]

One version gets fixed after a failure, uh 14 don't, now it's out of sync, now the model has several versions of the truth. You see where this is going. This is just bad. The cleaner doesn't ask whether an instruction is too long. It's smarter than that. [00:07:00 → 00:07:13]

It asks what job the instruction does, where that job should live, and who should update it the next time something changes. A lot of our theme along the way here has been about making sure we load the right information at the right time. [00:07:13 → 00:07:29]


## [00:07:27] Rule 4: Load It When You Need It

And the fourth rule really codes that clearly. It says we should load specialist knowledge when the work actually needs it. I had six different editorial guides that were loading whenever one writing skill ran. So, for example, the source guide matters a lot when I'm trying to do the research. And if I'm looking for examples for YouTube, I need to be finding that at the time when I'm wrestling with the YouTube script for you guys. [00:07:29 → 00:07:50]

All of that is great, but if you load all of it at the beginning, you're just loading a bunch of crud into your AI that is likely to produce worse results overall. Your research is worse because it's thinking about YouTube examples when it really should just be thinking about research. So in this world, the cleaner skill keeps the library, right? It keeps that library of specialist skills that's useful. It just changes when each part of the library appears. [00:07:50 → 00:08:13]

And this is where I think a lot of cleaning prompts don't really fully understand what they're doing. The goal is not to throw away any useful context. Your library can actually be quite large. [00:08:13 → 00:08:25]


## [00:08:25] Rule 5: Hard Rules Need Hard Checks

That's not bad. The fifth rule is that if you have hard requirements, they need hard checks. And so there's a difference between telling the model that you have a point of view and asking it to wrestle with that point of view with you. And there's a simple rule here that the cleaner skill will check for. If you have those kinds of rules, 50 word type rules where it's yes or no answers that the model can test for, those should be put into a schema that the model can test against. [00:08:25 → 00:08:49]

And the cleaner skill can help with that. The key principle here is that we let the system enforce the parts that a machine can verify, and that makes the harness lighter and safer at the same time. [00:08:49 → 00:09:00]


## [00:08:58] Rule 6: Build for the Model and Product

Now the sixth and final rule is to build for the model and the product actually doing the work. We want to be sophisticated enough that we can actually differentiate Fable 5 from Chat GPT 5. 6. If you use AI a lot, you understand that Fable 5 in Claude. ai doesn't have the same harness as Fable 5 in Claude Code or via the API. [00:09:00 → 00:09:17]

Chat GPT 5. 6 in Chat GPT Work isn't the same as in Codex and doesn't expose the same controls as it does via the API. So the model matters, but the product around it determines how skills load, which tools exist, what can be checked, and what proof comes back. What facts does the model need? What is it allowed to do? [00:09:17 → 00:09:36]

What must be true before the work is finished? What's our eval effect? And those core rules don't change just because I switched from Claude to chat GPT cuz the value on the work is the same, right? We're testing the same work across both harnesses. That setup passed every single delivery requirement three times out of three, right? [00:09:36 → 00:09:53]

Like it actually delivered what it needed to because it was suited to Fable. And as I discussed the richer skills, the heavier harness, they produced richer analysis, but Fable was unable to meet my output constraints. And so there were issues that Fable had just because it was struggling with the thicker skill. And so what does this teach us about how Fable works, right? You give it the real outcome, you give it context that it can't infer, you give it room to inspect the problem, and you let it plan its own approach usefully. [00:09:53 → 00:10:20]

And then you bring in specialist material when the work reaches that phase, which the cleaner skill can help you so that you invoke it at the right time, or you can let Fable invoke it at the right time. And what failed was narrating the entire method in that big thick skill file before Fable had even seen the job, and expecting all of that prompt prose to enforce like JSON and word count requirements. That's just not going to work really well, even if Fable's very good at rule following. And this is not about starving Fable of context, by the way. The full method helped it to notice more stuff, but the depth should arrive when the work needs it, not all up front in a way that confuses the model, right? [00:10:19 → 00:10:59]


## [00:10:58] The Codex Audit Results

So here we have the audit results. 66 skill roots and 172 instruction assets. 27,000 description characters against 8,000 Codex Discovery budget. That is a big problem. It's a big problem because it means Codex can't read it. [00:10:59 → 00:11:14]

There was an 18,000 word content route or skill with a minimum fan in. Basically, it was a skill leading into skills that 18,000 words. Uh provenance governance, how you handle sources distributed across 15 different skills, that's what I talk about. And only six of the 66 root skills had a detected local eval, right? I had evals on six of them, but I didn't have them on the other 60, and I needed to improve that. [00:11:14 → 00:11:42]

And it's all about consistency with Codex, right? Schemas, tool restrictions, file checks, and a run receipt, they all carry the exact same requirements from skill to skill so that Codex is able to operate very consistently. So, the Codex chat GPT cleanup is not simply make the prompt shorter. It's make the right route to the skill easy to find, then load the depth at the right point. And the receipt that you have, which is important for Codex, it records the model, the reasoning setting, the tools, the skills, the fallbacks, and the checks that ran, so that you can get a sense over time of where there are problems. [00:11:42 → 00:12:13]

It's like a diagnostic for your engine, right? You can figure out what's going on. [00:12:13 → 00:12:17]


## [00:12:17] Fable 5 vs. ChatGPT 5.6 Failure Modes

If we compare the two models together, Fable's failure mode showed up after the method became too heavy for the delivery job, whereas chat GPT 5. 6's failure mode in Codex showed up much earlier, while the system was still trying to find the right method at all, and it was just having trouble routing across a really huge harness layer. Both models benefit from selective loading, right? Both benefit from including those hard checks I talked about, but for very different immediate reasons. And that has to do with how these models work. [00:12:17 → 00:12:47]

Like Fable 5 sorting through a lot of context and trying to figure out how to do the best job and kind of overloading itself is a Fable 5 way to fail. [00:12:47 → 00:12:55]


## [00:12:54] A Clean Harness Without the Barnacles

Harnesses grow barnacles like ships. Ultimately, what I want is a system that helps us work well. I want the harnesses to evolve and stay clean and not just collect these barnacles of extra point solutions, extra additions, extra text files, extra skills that I randomly find on the internet because I found a tweet somewhere, add it in, and now I don't know what I'm doing because, you know, chat GPT is overwhelmed or Fable 5 gets too fat a skill, or whatever the failure mode may be. I want a clean harness that lets me get work done in a way that's efficient. That's why I built this cleaner skill. [00:12:55 → 00:13:26]

And this matters, right? If you're a product manager, it means that you have like a clean, simple note that loads the right PRD skills at the right time. If If you're a developer, it means having one source of truth instead of several instruction files arguing about how the repository work. But we need to make sure that they add into the system we have in a way that's efficient. And if you're just using ChatGPT or Claude at home or at work, it means that your old memories, your project files, your examples, your corrections stop quietly shaping answers in ways you don't necessarily intend. [00:13:26 → 00:13:57]

You may have given Claude or ChatGPT a correction 6 months ago that it's remembering and over applying now that you have a new model. So, for example, you and may have told it a few months ago, "You have to show me the step-by-step because back in November that was really important. " But now you don't need to do that cuz the models are good, right? And so, those are the kinds of things the cleaner scope catches. [00:13:57 → 00:14:18]


## [00:14:17] Own the System Around Your AI

Ultimately, the goal is simple. Your AI should become easier to use to do useful work because the system around it should become easier to understand. Once you can see that system, you can actually own it. You can tell which controls protect you, which need one single home, right? Which should arrive later in the process, which should become real locks instead of just polite reminders. [00:14:18 → 00:14:40]


## [00:14:39] The Cleaner Skill

I put the complete cleaner over on the Substack, you can find it. You can install it once, you can point it at the AI setup or project of your choosing, and you can just let it show everything that's accumulated. It gives you a map of the harness and the cleaning decisions. It's going to give you a plain English before and after and a receipt showing what ran when you allow it to run and and and run those corrections. You can review the changes before anything important moves. [00:14:40 → 00:15:05]

I don't want this to be something that surprises you in any way. I have a feeling that a lot of us are going to discover that we built a lot more than we realized. I know I certainly did, and so I wanted to showcase that here and show you all how bloated my harness had become and how much I needed to clean. I hope this has been useful for you. I'm going to keep drilling in on these new models. [00:15:04 → 00:15:22]

I'll keep updating the cleaner skill. Please let me know in the comments one how it works for you, but also let me know what other models you'd like me to optimize the cleaner skill for because of course there are plenty of other models besides Claude and chat GPT and I'm happy to start working on that as well. Would love to kind of expand this and make this more useful for the community over time and I look forward to showing you what I've built with my new and improved harness on Friday. [00:15:22 → 00:15:47]
