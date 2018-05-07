# Introduction to Writing Tutorials in Cloud Shell


## Let's get started!

Get your users up and running quickly with your project by including an interactive tutorial.

This guide will show you how to build your own interactive tutorial (like this one). It'll also walk you through generating a button that users can use to launch your finished tutorial.

**Time to complete**: About 10 minutes

Click the **Continue** button to move to the next step.


## What is Cloud Shell?

Before we jump in, let's briefly go over what Cloud Shell can do.

Cloud Shell is a personal hosted Virtual Machine which comes pre-loaded with developer tools for Google Cloud products. This interactive shell environment comes with a built-in code editor, persistent disk storage, and web preview functionality. To use command-line access alone, visit [console.cloud.google.com/cloudshell](https://console.cloud.google.com/cloudshell).

You can direct your users to Cloud Shell to help them quickly get started with your project; giving them an opportunity to step through a use case and familiarize themselves with your project's functionality.

Continue on to the next step to start setting up your tutorial.


## In-context tutorials

What you're looking at now is an in-context tutorial.

The content is shown along with the Cloud Shell environment where you can carry out the tutorial steps. Having the tutorial and development environment open in the same place makes it easier for your users to start using your project through a straightforward single screen experience.

Try running a command now:
```bash
echo "Hello Cloud Shell"
```

**Tip**: Click the copy button on the side of the code box and paste the command in the Cloud Shell terminal to run it.

Next, you’ll write and launch a basic tutorial.


## Opening the editor

You can edit a file stored in Cloud Shell using Cloud Shell’s built-in text editor.

*  To start, open the editor by clicking on the <walkthrough-orion-editor-icon></walkthrough-orion-editor-icon> icon.
*  Look at the source file for this tutorial by opening `tutorial.md`.
*  Try making a change to the file for this tutorial, then saving it using the <walkthrough-editor-spotlight spotlightId="fileMenu">file menu</walkthrough-editor-spotlight>.

To restart the tutorial with your changes, run:
```bash
cloudshell launch-tutorial -d tutorial.md
```

Next, you will learn how to format the text in a tutorial.


## Writing in Markdown

To write your tutorial, use [Markdown](https://en.wikipedia.org/wiki/Markdown) and follow these guidelines:


### Edit the title

Modify the title of this tutorial ('# Introduction to writing tutorials in Cloud Shell') by changing it to:

    # Teach me to write a tutorial


### Add a new step

Next, add a step just after the title like this:

    ## Step 1
    This is a new step I’ve just added.
Each 'step' of a tutorial is displayed on one page. To move through steps, users use the 'Back' and 'Continue/Forward' buttons.


### Add underlying items to a step

To list items that are part of a tutorial step under a particular step heading, add them as such:

    ### This is an item under your first step

The tutorial engine also supports Markdown features like links and images. Note, **including HTML is not supported**.

To recap, a **title** is marked with a **level 1** heading, a **step** with a **level 2** heading, and an **item** with a **level 3** heading.


### Restart to see changes

To see your changes, restart the tutorial by running:
```bash
cloudshell launch-tutorial -d tutorial.md
```

Next up, adding helpful links and icons to your tutorial.


## Special tutorial features

In the Markdown for your tutorial, you may include special directives that are specific to the tutorial engine. These allow you to include helpful shortcuts to actions that you may ask a user to perform.


### Trigger file actions in the text editor
To include a link to <walkthrough-editor-open-file filePath="cloud-shell-tutorials/tutorial.md">open a file for editing</walkthrough-editor-open-file>, use:

    <walkthrough-editor-open-file
        filePath="cloud-shell-tutorials/tutorial.md">
      open a file for editing
    </walkthrough-editor-open-file>


### Highlight a UI element

You can also direct the user’s attention to an element on the screen that you want them to interact with.

You may want to show people where to find the web preview icon to view the web server running in their Cloud Shell virtual machine in a new browser tab.

Display the web preview icon <walkthrough-web-preview-icon></walkthrough-web-preview-icon> by including this in your tutorial’s Markdown:

    <walkthrough-web-preview-icon>
    </walkthrough-web-preview-icon>

To create a link that shines a <walkthrough-spotlight-pointer spotlightId="devshell-web-preview-button">spotlight on the web preview icon</walkthrough-spotlight-pointer>, add the following:

    <walkthrough-spotlight-pointer
        spotlightId="devshell-web-preview-button">
      spotlight on the web preview icon
    </walkthrough-spotlight-pointer>

You can find a list of supported spotlight targets in the [documentation for Cloud Shell Tutorials](https://cloud.google.com/shell/docs/tutorials).

You've now built a tutorial to help onboard users!

Next, you’ll create a button that allows users to launch your tutorial in Cloud Shell.


## Creating a button for your site

Here is how you can create a button for your website, blog, or open source project that will allow users to launch the tutorial you just created.


### Creating an HTML Button

To build a link for the 'Open in Cloud Shell' feature, start with this base HTML and replace the following:

**`YOUR_REPO_URL_HERE`** with the project repository URL that you'd like cloned for your users in their launched Cloud Shell environment.

**`TUTORIAL_FILE.md`** with your tutorial’s Markdown file. The path to the file is relative to the root directory of your project repository.

    <a  href="https://console.cloud.google.com/cloudshell/open?git_repo=YOUR_REPO_URL_HERE&tutorial=TUTORIAL_FILE.md">
      <img alt="Open in Cloud Shell" src="http://gstatic.com/cloudssh/images/open-btn.png">
    </a>

Once you've edited the above HTML with the appropriate values for `git_repo` and `tutorial`, use the HTML snippet to generate the 'Open in Cloud Shell' button for your project.


### Creating a Markdown Button

If you are posting the 'Open in Cloud Shell' button in a location that accepts Markdown instead of HTML, use this example instead:

    [![Open this project in Cloud Shell](http://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=YOUR_REPO_URL_HERE&page=editor&tutorial=TUTORIAL_FILE.md)

Likewise, once you've replaced `YOUR_REPO_URL_HERE` and `TUTORIAL_FILE.md` in the 'Open in Cloud Shell' URL as described above, the resulting Markdown snippet can be used to create your button.


## Congratulations

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

You’re all set!

You can now have users launch your tutorial in Cloud Shell and have them start using your project with ease.


