
# It Speaks! Create synthetic speech using Cloud Text-to-Speech

This interactive tutorial will show you how to use the Cloud Text-to-Speech API, walking you through the setup steps, and showing how to use the API to generate spoken-word audio data from your content.


## Overview

The Cloud Text-to-Speech API lets you create audio files of machine-generated, or  *synthetic, * human speech. You provide the content as text or  [Speech Synthesis Markup Language (SSML)](https://www.w3.org/TR/speech-synthesis/), specify a  *voice*  (a unique 'speaker' of a language with a distinctive tone and accent), and configure the output; the Text-to-Speech API returns to you the content that you sent as spoken word, audio data, delivered by the voice that you specified.

In this lab, you will create a series of audio files using the Cloud Text-to-Speech API.

What you'll learn:

* Listing all of the synthetic voices available through the Text-to-Speech API
* Creating a Text-to-Speech API request and calling the API with curl, providing both text and  [SSML](https://cloud.google.com/text-to-speech/docs/ssml)
* Configuring the setting for audio output, including specifying a device profile for audio playback

![Text-to-speech API graphic](https://cloud.google.com/images/products/text-to-speech/high-fidelity.svg)

**Time to complete**: About 30 minutes

Click the **Continue** button to move to the next step.

## Setup 

### Create a Google Cloud Platform (GCP) project. **If you already have a Google Cloud Platform account and project, you can skip this step.**

If you don't have a Google Cloud Platform (GCP) account yet, create one [here](https://cloud.google.com/free/). Be sure to sign up for free trial credits.

If you don't have a Google Cloud Platform (GCP) project yet, create one [here](https://console.cloud.google.com/).

### Set your Project ID in your shell environment

In the [Cloud Console](https://console.cloud.google.com/), under the "Project Info" in the Home view, find your Project ID.

In the Cloud Shell, save your project ID in an environment variable, which you'll use in subsequent steps.
```bash
  export PROJECT=<your-project-id>
```

Now run the following command to ensure that the Cloud Shell is using the correct GCP project:

```bash
  gcloud config set project $PROJECT
```

Next, you'll enable the Text-to-Speech API for your project, if you've not already done so.

### Enable the Cloud Text-to-Speech API

Click on [this link](https://console.cloud.google.com/flows/enableapi?apiid=texttospeech.googleapis.com) to enable the Text-to-Speech API for your project, if you haven't already done so. Select your project from the pull-down menu (you may need to search for it by name) and then click the 'continue' button.

After you've enabled it, just return to this window. 

Next, you'll create a service account to authenticate with the Text-to-Speech API.

## Create a service account to authenticate with the Text-to-Speech API

You'll use a *service account* to authenticate your calls to the Text-to-Speech API. To create a service account, run the following command in Cloud Shell.

```bash
gcloud iam service-accounts create tts-codelab
```

<!-- For this next step, you need to copy the name of your Google Cloud project. Run the following command and copy the output.

```bash
gcloud config get-value project 2> /dev/null
``` -->

Now you need to generate a key to use that service account. To create and download a key, run the following command in Cloud Shell. (This command requires that you've set your `$PROJECT` environment variable as described in a previous step).

```bash
gcloud iam service-accounts keys create tts-codelab.json --iam-account tts-codelab@$PROJECT.iam.gserviceaccount.com
```

Finally, set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable to the location of your key file.

```bash
export GOOGLE_APPLICATION_CREDENTIALS=tts-codelab.json
```

Next, you'll explore the available Text-to-Speech voices.

## Get a list of available voices

As mentioned previously, the Cloud Text-to-Speech API provides many different voices and languages that you can use to create audio files. You can use any of the  [available voices](https://cloud.google.com/text-to-speech/docs/voices) as the speaker for your content.

> **Note**: The Text-to-Speech API includes several premium voices, known as  [WaveNet voices](https://cloud.google.com/text-to-speech/docs/wavenet#wavenet_voices), that generate more natural-sounding synthetic speech. These voices are also a bit more expensive than other available voices. See the  [Cloud Text-to-Speech pricing page](https://cloud.google.com/text-to-speech/pricing) for more details.


The following `curl` command gets the list of all the voices you can select from when creating synthetic speech using the Text-to-Speech API.

```bash
curl -H "Authorization: Bearer "$(gcloud auth application-default print-access-token) \
    -H "Content-Type: application/json; charset=utf-8" \
    "https://texttospeech.googleapis.com/v1/voices"
```

The Text-to-Speech API returns a JSON-formatted result that looks similar to the following:

```json
{
  "voices": [
    {
      "languageCodes": [
        "es-ES"
      ],
      "name": "es-ES-Standard-A",
      "ssmlGender": "FEMALE",
      "naturalSampleRateHertz": 24000
    },
    {
      "languageCodes": [
        "ja-JP"
      ],
      "name": "ja-JP-Standard-A",
      "ssmlGender": "FEMALE",
      "naturalSampleRateHertz": 22050
    },
    {
      "languageCodes": [
        "pt-BR"
      ],
      "name": "pt-BR-Standard-A",
      "ssmlGender": "FEMALE",
      "naturalSampleRateHertz": 24000
    },
    ...
  ]
}
```

Looking at the results from the  `curl` command, you'll notice that each voice has four fields:

* `name`: The ID of the voice that you provide when you request that voice.
* `ssmlGender`: The gender of the voice to speak the text, as defined in the  [SSML W3 Recommendation](https://www.w3.org/TR/speech-synthesis11/#edef_voice).
* `naturalSampleRateHertz`: The sampling rate of the voice.
* `languageCodes`: The list of language codes associated with that voice.

You'll also see that some languages have several voices to choose from. You can scope the results returned from the API to just a single language code:

```bash
curl -H "Authorization: Bearer "$(gcloud auth application-default print-access-token) \
    -H "Content-Type: application/json; charset=utf-8" \
    "https://texttospeech.googleapis.com/v1/voices?language_code=en"
```

In the next step, you'll do some actual speech generation.

## Create synthetic speech from text

Now that you've seen how to get the names of voices to speak your text, it's time to create some synthetic speech! 

Bring up the `synthesize-text.json` file 
<walkthrough-editor-open-file filePath="cloud-shell-tutorials/ml/cloud-tts-intro/synthesize-text.json">in the text editor.</walkthrough-editor-open-file>
It should look like this:

```json
{
    'input':{
        'text':'Cloud Text-to-Speech API allows developers to include 
           natural-sounding, synthetic human speech as playable audio in 
           their applications. The Text-to-Speech API converts text or 
           Speech Synthesis Markup Language (SSML) input into audio data 
           like MP3 or LINEAR16 (the encoding used in WAV files).'
    },
    'voice':{
        'languageCode':'en-gb',
        'name':'en-GB-Standard-A',
        'ssmlGender':'FEMALE'
    },
    'audioConfig':{
        'audioEncoding':'MP3'
    }
}
```

The JSON-formatted request body provides three objects: 

* The `input` object provides the text to translate into synthetic speech. 
* The `voice` object specifies the voice to use for the synthetic speech. 
* The `audioConfig` object tells the Text-to-Speech API what kind of audio encoding to send back.

Use the following code to call the Text-to-Speech API using the `curl` command. The output of this call is saved to a file called `synthesize-text.txt`.

```bash
curl -H "Authorization: Bearer "$(gcloud auth application-default print-access-token) \
  -H "Content-Type: application/json; charset=utf-8" \
  -d @synthesize-text.json "https://texttospeech.googleapis.com/v1/text:synthesize" \
  > synthesize-text.txt
```

Open the  `synthesize-text.txt` file in the text editor, or in the Cloud Shell run:

```bash
more synthesize-text.txt
```

You'll notice that the Text-to-Speech API provides the audio output in base64-encoded text assigned to the `audioContent` field, similar to what's shown below.

```json
{
  "audioContent": "//NExAASGoHwABhGudEACdzqFXfRE4EY3AACkD/zX4ADf/6J/[...]"
}
```

To translate the response into audio, you need to select the audio data it contains and decode it into an audio file (MP3, in this case). Although there are many ways that you can do this, in this codelab we'll use some really simple Python code. Don't worry if you're not a Python expert; you need only create the file and invoke it from the command line.

Bring up the `tts_decode.py` file 
<walkthrough-editor-open-file filePath="cloud-shell-tutorials/ml/cloud-tts-intro/tts_decode.py">in the text editor.</walkthrough-editor-open-file>
It should look like this:

```py
import argparse
from base64 import decodestring
import json

"""
Usage:
        python tts_decode.py --input "synthesize-text.txt" \
        --output "synthesize-text-audio.mp3"

"""

def decode_tts_output(input_file, output_file):
    """ Decode output from Cloud Text-to-Speech.
        
    input_file: the response from Cloud Text-to-Speech
    output_file: the name of the audio file to create
        
    """

    with open(input_file) as input:
        response = json.load(input)
        audio_data = response['audioContent']
            
        with open(output_file, "wb") as new_file:
            new_file.write(decodestring(audio_data))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="Decode output from Cloud Text-to-Speech",
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument('--input',
                       help='The response from the Text-to-Speech API.',
                       required=True)
    parser.add_argument('--output',
                       help='The name of the audio file to create',
                       required=True)

    args = parser.parse_args()
    decode_tts_output(args.input, args.output)
```

Now, to create an audio file from the response you received from the Text-to-Speech API, run the following command from Cloud Shell. This creates a new MP3 file named `synthesize-text-audio.mp3`.

```bash
python tts_decode.py --input "synthesize-text.txt" --output "synthesize-text-audio.mp3"
```

Of course, since the `synthesize-text-audio.mp3` lives in the cloud, you can't just play it directly from Cloud Shell! To listen to the file, you can create a Web server hosting a simple web page that embeds the file as playable audio (from an HTML <`audio>` control).

Bring up the `index.html` file
<walkthrough-editor-open-file filePath="cloud-shell-tutorials/ml/cloud-tts-intro/index.html">in the text editor.</walkthrough-editor-open-file>
It should look like this:

```html
<html>
  <body>
  <h1>Cloud Text-to-Speech codelab</h1>
  <p>
  Output from synthesizing text:
  </p>
  <audio controls>
    <source src="synthesize-text-audio.mp3" />
  </audio>
  </body>
</html>
```

Next, start a simple Python HTTP server from the Cloud Shell command prompt:

```bash
python -m SimpleHTTPServer 8080
```

Finally, click the **Web Preview** button ![web preview icon](https://storage.googleapis.com/aju-dev-demos-codelabs/images/web_preview_icon.png) and then select the port number (8080) from the displayed menu. In a new browser window, you should see something like the following:

![tts output](https://storage.googleapis.com/aju-dev-demos-codelabs/images/tts_browser1.png)

**Note**: if you can't see the Web Preview icon, try scrolling the cloud shell pane horizontally to the left. It may be hiding behind the tutorial pane.

Play the audio embedded on the page. You'll hear the synthetic voice speak the text that you provided to it!

(When you're done listening to the audio files,  you can shut down the HTTP server by pressing CTRL + C in Cloud Shell.)

Next, you'll create speech using a markup language.

## Create synthetic speech from SSML

In addition to using text, you can also provide input to the Text-to-Speech API in the form of  [Speech Synthesis Markup Language (SSML)](https://cloud.google.com/text-to-speech/docs/ssml). SSML defines an XML format for representing synthetic speech. Using SSML input, you can more precisely control pauses, emphasis, pronunciation, pitch, speed, and other qualities in the synthetic speech output.

Bring up the `synthesize-ssml.json` file
<walkthrough-editor-open-file filePath="cloud-shell-tutorials/ml/cloud-tts-intro/synthesize-ssml.json">in the text editor.</walkthrough-editor-open-file>

It should look like this:

```json
{
    'input':{
        'ssml':'<speak><s>
           <emphasis level="moderate">Cloud Text-to-Speech API</emphasis> 
           allows developers to include natural-sounding
           <break strength="x-weak"/>
           synthetic human speech as playable audio in their 
           applications.</s>
           <s>The Text-to-Speech API converts text or 
           <prosody rate="slow">Speech Synthesis Markup Language</prosody> 
           <say-as interpret-as=\"characters\">SSML</say-as>
           input into audio data 
           like <say-as interpret-as=\"characters\">MP3</say-as> or 
           <sub alias="linear sixteen">LINEAR16</sub>
           <break strength="weak"/>
           (the encoding used in 
           <sub alias="wave">WAV</sub> files).</s></speak>'
    },
    'voice':{
        'languageCode':'en-gb',
        'name':'en-GB-Standard-A',
        'ssmlGender':'FEMALE'
    },
    'audioConfig':{
        'audioEncoding':'MP3'
    }
}
```

You'll notice that the `input` object of the JSON payload to send includes some different stuff this time around. Rather than a `text` field, the `input` object has a `ssml` field instead. The `ssml` field contains XML-formatted content the `<speak>` element as its root. Each of the elements present in this XML representation of the input affects the output of the synthetic speech.

Specifically, the elements in this sample have the following effects:

* `<s>` contains a sentence.
* `<emphasis>` adds stress on the enclosed word or phrase.
* `<break>` inserts a pause in the speech.
*  `<prosody>` customizes the pitch, speaking rate, or volume of the enclosed text, as specified by the `rate`, `pitch`, or `volume` attributes.
* `<say-as>` provides more guidance about how to interpret and then say the enclosed text, for example, whether to speak a sequence of numbers as ordinal or cardinal.
* `<sub>` specifies a substitution value to speak for the enclosed text.   


> **Note**: You can see the full list of SSML elements supported by Cloud Text-to-Speech by reviewing the [SSML reference](https://cloud.google.com/text-to-speech/docs/ssml).

Use the following code to call the Text-to-Speech API, which saves the output to a file called `synthesize-ssml.txt`.

```bash
curl -H "Authorization: Bearer "$(gcloud auth application-default print-access-token) \
  -H "Content-Type: application/json; charset=utf-8" \
  -d @synthesize-ssml.json "https://texttospeech.googleapis.com/v1/text:synthesize" \
  > synthesize-ssml.txt
```

Again, you need to decode the output from the Text-to-Speech API before you can hear the audio. Run the following command to generate an audio file named `synthesize-ssml-audio.mp3` using the `tts_decode.py` utility that you created previously.

```bash
python tts_decode.py --input "synthesize-ssml.txt" --output "synthesize-ssml-audio.mp3"
```

Next, open the `index.html` file
<walkthrough-editor-open-file filePath="cloud-shell-tutorials/ml/cloud-tts-intro/index.html">in the text editor</walkthrough-editor-open-file> again.
Edit the file to replace the contents of the file with the following HTML, then save the file:

```html
<html>
  <body>
  <h1>Cloud Text-to-Speech codelab</h1>
  <p>
  Output from synthesizing text:
  </p>
  <audio controls>
    <source src="synthesize-text-audio.mp3" />
  </audio>
  <p>
  Output from synthesizing SSML:
  </p>
  <audio controls>
    <source src="synthesize-ssml-audio.mp3" />
  </audio>
  </body>
</html>
```

Then, start a simple Python HTTP server from the Cloud Shell command prompt.

```bash
python -m SimpleHTTPServer 8080
```

As before, click the **Web Preview** button ![web preview icon](https://storage.googleapis.com/aju-dev-demos-codelabs/images/web_preview_icon.png) and then select the 8080 port number from the displayed menu. In the new browser window, you should see something like the following:

![tts browser output](https://storage.googleapis.com/aju-dev-demos-codelabs/images/tts_browser_output.png)

Play the two embedded audio files. Notice the differences in the SSML output: although both audio files say the same words, the SSML output speaks them a bit differently, adding pauses and different pronunciations for abbreviations.

Next, you'll add further customization to the output of the Text-to-Speech API.

## Configure audio output and device profiles

Going beyond SSML, you can provide even more customization to your synthetic speech output created by the Text-to-Speech API. You can specify other audio encodings, change the pitch of the audio output, and even request that the output be optimized for a specific type of hardware.

Bring up the `synthesize-with-settings.json` file
<walkthrough-editor-open-file filePath="cloud-shell-tutorials/ml/cloud-tts-intro/synthesize-with-settings.json">in the text editor.</walkthrough-editor-open-file>

It should look like this:

```json
{
    'input':{
        'text':'The Text-to-Speech API is ideal for any application 
          that plays audio of human speech to users. It allows you
          to convert arbitrary strings, words, and sentences into
          the sound of a person speaking the same things.'
    },
    'voice':{
        'languageCode':'en-us',
        'name':'en-GB-Standard-A',
        'ssmlGender':'FEMALE'
    },
    'audioConfig':{
      'speakingRate': 1.15,
      'pitch': -2,
      'audioEncoding':'OGG_OPUS',
      'effectsProfileId': ['headphone-class-device']
    }
}
```

Looking at this JSON payload, you notice that the `audioConfig` object contains some additional fields now:

* The `speakingRate` field specifies a speed at which the speaker says the voice. A value of 1.0 is the normal speed for the voice, 0.5 is half that fast, and 2.0 is twice as fast. 
* The `pitch` field specifies a difference in tone to speak the words. The value here specifies a number of semitones lower (negative) or higher (positive) to speak the words.
* The `audioEncoding` field specifies the audio encoding to use for the data. The accepted values for this field are `LINEAR16`, `MP3`, and `OGG_OPUS`.
* The `effectsProfileId` field requests that the Text-to-Speech API optimizes the audio output for a specific playback device. The API applies an  [predefined audio profile](https://cloud.google.com/text-to-speech/docs/audio-profiles) to the output that enhances the audio quality on the specified class of devices. 

> **Important**: The Audio Profiles feature is in Beta release status. Review the  [documentation](https://cloud.google.com/text-to-speech/docs/audio-profiles)  for details about how to use it in your application. All other settings described here are generally available for normal use in your application.
</aside>

Use the following code to call the Text-to-Speech API using the `curl` command. The output of this call is saved to a file called `synthesize-with-settings.txt`.

```bash
curl -H "Authorization: Bearer "$(gcloud auth application-default print-access-token) \
  -H "Content-Type: application/json; charset=utf-8" \
  -d @synthesize-with-settings.json "https://texttospeech.googleapis.com/v1beta1/text:synthesize" \
  > synthesize-with-settings.txt
```

Run the following command to generate an audio file named `synthesize-with-settings-audio.ogg` from the output received from the Text-to-Speech API.

```bash
python tts_decode.py --input "synthesize-with-settings.txt" --output "synthesize-with-settings-audio.ogg"
```

Next, again open the `index.html` file
<walkthrough-editor-open-file filePath="cloud-shell-tutorials/ml/cloud-tts-intro/index.html">in the text editor.</walkthrough-editor-open-file>
Edit the file to replace the contents of the file with the following HTML, then save the file.

```html
<html>
  <body>
  <h1>Cloud Text-to-Speech codelab</h1>
  <p>
  Output from synthesizing text:
  </p>
  <audio controls>
    <source src="synthesize-text-audio.mp3" />
  </audio>
  <p>
  Output from synthesizing SSML:
  </p>
  <audio controls>
    <source src="synthesize-ssml-audio.mp3" />
  </audio>
  </body>
  <p>
  Output with audio settings:
  </p>
  <audio controls>
    <source src="synthesize-with-settings-audio.ogg" />
  </audio>
</html>
```

Now, restart the Python HTTP server from the Cloud Shell command prompt.

```bash
python -m SimpleHTTPServer 8080
```

As before, click the **Web Preview** button ![web preview icon](https://storage.googleapis.com/aju-dev-demos-codelabs/images/web_preview_icon.png) and then select the correct port number from the displayed menu. In the new browser window, you should see something like the following:

![tts browser output](https://storage.googleapis.com/aju-dev-demos-codelabs/images/tts_browser3.png)

Play the third embedded audio file. Notice that the voice on the audio speaks a bit faster and lower than the previous examples.

## Congratulations!

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

[![twitter-share](https://storage.googleapis.com/mco-tutorials/twitter2.png)](https://twitter.com/intent/tweet?text=I%20just%20learned%20how%20%20to%20use%20the%20Google%20Cloud%20Text-to-Speech%20API%20-%20http://bit.ly/2CEzqZJ%20%23GCP)

In this codelab, you learned how to create synthetic speech using the Cloud Text-to-Speech API.

#### What we've covered

* Listing all of the synthetic voices available through the Text-to-Speech API.
* Creating a Text-to-Speech API request and calling the API with `curl`, providing both text and [SSML](https://cloud.google.com/text-to-speech/docs/ssml).
* Configuring the settings for audio output, including specifying a device profile for audio playback.

#### Next Steps

* Check out the detailed documentation for the  [Text-to-Speech API on cloud.google.com.](https://cloud.google.com/text-to-speech/docs/)
* Learn how to create synthetic speech [using the client libraries for the Text-to-Speech API](https://cloud.google.com/text-to-speech/docs/quickstart-client-libraries).


