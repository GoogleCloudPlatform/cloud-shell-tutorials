# Introduction to formatting and filtering with gcloud

## Let's get started!

This guide will show you how to use filter and format flags in a variety of ways with your `gcloud` commands in order to produce meaningful results.

**Time to complete**: About 7 minutes

**Prerequisites**: 2 or more projects to test filtering and formatting with.

To view available projects, run:
```bash
gcloud projects list
```

To create a project, run:
```bash
gcloud projects create <ENTER-PROJECT-ID>
```

**Tip**: Use `--help` with any gcloud command to bring up its documentation.

Click the **Continue** button to move to the next step.

## What can the format flag do?

The format flag (along with projections - more on that coming up) can be used to format the default output (pretty-printed messages to `stdout`).

Among the variety of formats available, output can be printed in `json`, `csv`, `text`, `value`, `table`, and `yaml` format.

**Tip**: When scripting with `gcloud`, don’t depend on the raw output of `gcloud` commands; they may change with a future release! Use the `--format` flag to mitigate the effects of these changes and script against a more predictable structure (like a json-formatted result).

For starters, run this `gcloud` command with a trusty format flag:
```bash
gcloud projects list --format=json --limit=1
```
To display a flattened version of this nested data structure instead, run:
```bash
gcloud projects list --format=flattened --limit=1
```
Continue on to the next step to discover more involved uses of the `--format` flag.

## Format but fancier

There’s a lot you can accomplish with just the format flag.

To display the list of your projects as a formatted box with a title and columns for name and state, run:
```bash
gcloud projects list --format="table[box,title=Projects](name, lifecycleState)"
```

To print a csv instead, with no heading and a specific separator, run:
```bash
gcloud projects list --format="csv[no-heading,separator=' '](name, lifecycleState)"
```

Continue on to learn about projections.


## Project, then format

Before we move forward, we need to define the previously alluded term of  **projections**.

A projection is a list of keys that selects a resource’s data values. You can read about all available projections using `gcloud topic projections`.

It’s often used along with the format flag when the data of the desired format (like `csv` and `table`) cannot be nested (though it can be used with nestable data). It is also used to transform or apply logic directly to the data returned.

This is a format flag being used on a projection:
```bash
gcloud projects list --format="csv(name,createTime)"
```

**Tip**: Run gcloud projects list --format=text --limit=1 to display a more complete set of the output’s fields.

## Project with style

Taking this a step further, you can control how these fields are displayed using field attributes; these are properties like the label value of a column’s output, alignment of column content, and the sort order of rows.

**Tip**: Fields and field attributes can be defined using this structure: --format=type[attribute,...]
(field.transform():attribute,...).

In practice, this would look like:
```bash
gcloud compute instances list --format="json(zone.basename():sort=1:label=zone,name)"
```

To return the last URL path component, use basename():
```bash
gcloud compute zones list --format="table[box,title=Zones](id:label=zone_id, selfLink.basename())"
```

To align column content to the center, sort primarily by name (and secondarily by zone) and give the zone column an appropriate label, run:
```bash
gcloud compute zones list --format="table[box,title=Zones](name:sort=1:align=center, region.basename():label=region:sort=2, status)"
```

To display a boxed list of all your projects, ordered in reverse alphabetical order along with creation times in a d-m-y format:

```bash
gcloud projects list --format="table[box](name:sort=1:reverse, createTime.date('%d-%m-%Y'))"
```

## Filter out the cruft

In addition to defining the relevant format of output, you can also restrict the result based on conditionals.

To filter out the available compute zones to display a list of those with asia-prefixed zones, run:

```bash
gcloud compute zones list --filter="region:asia*"
```

To list projects with a parent type that is not an organization, run:

```bash
gcloud projects list --format=json --filter="NOT parent.type:organization"
```

To list projects created after a specific date (while making the comparison with a nifty projection), run:

```bash
gcloud projects list --format=json --filter="createTime.date('%d-%m-%Y')>1-1-2017"
```

For a more extensive list of available filter operations, run `gcloud topic filters --help`.

You’re all done!

## Congratulations

<walkthrough-conclusion-trophy></walkthrough-conclusion-trophy>

You’re all set!

You can now filter and format to your heart’s content. Read the help of `gcloud topic filters` and `gcloud topic formats` for a detailed look at what these flags can do.

**Don’t forget to clean up after yourself**: If you created test projects, be sure to delete them to avoid unnecessary charges. Use `gcloud projects delete <PROJECT-ID>`.
