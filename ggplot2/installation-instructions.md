# R, RStudio & ggplot2 installation

In order to get up and running with `R` and `ggplot2` you'll need to install three things to your laptop:

1. The `R` language itself
2. RStudio, the IDE for `R`
3. The `ggplot2` package, installed from within `R`

Here's how to do that.

### 1. Installing R

`R` is hosted online on something called CRAN (the Comprehensive R Archive Network). CRAN is mirrored on dozens of sites globally. One of these sites is Imperial College London, which is where we'll download `R` from.

To download and install `R`:

1. Head over to [this](https://cran.ma.imperial.ac.uk/) link
2. Click on either the _base_ or _install R for the first time_ links (they both go to the same place)
3. Click the big button at the top of the page which says 'Download R for Windows'

This will download an executable file (`.exe`) which you'll need to run on your laptop to install `R`. For first-time users, select all of the default options. If you need help then check online or ask [Jim Leach](mailto:jim.leach@kpmg.co.uk).

Once this is done, you should see the `R` program on your start menu and/or desktop (if you created a shortcut). Ignore this for now as the basic `R` program is not the nicest way to interact with the language. For that you'll want to:

### 2. Installing RStudio

RStudio is the best IDE ('integrated development environment') for `R`. It's where you do your coding, run your analyses and generally 'work' with `R`.

To download and install RStudio:

1. Head to the [downloads page](https://www.rstudio.com/products/rstudio/download/)
2. Click on 'Download' underneath RStudio Desktop edition
3. Select the most recent version for Windows underneath 'Installers for Supported Platforms'

This will download another executable file (`.exe`) which you'll need to run on your laptop to install RStudio. Again, select all the default options and if you get stuck check online or ask [Jim Leach](mailto:jim.leach@kpmg.co.uk).

Once this is done you should get a new RStudio icon/entry in your start menu. Open it up and you should see an area labelled 'Console' on the left hand side. You're now ready to:

### 3. Installing `ggplot2`

Open RStudio and select the 'Console' area. You should see something like this:

```

R version 3.3.2 (2016-10-31) -- "Sincere Pumpkin Patch"
Copyright (C) 2016 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

 >
```
The `>` prompt is where you can enter `R` commands. Type in the following command and then press 'enter' to install `ggplot2`:

```
> install.packages("ggplot2")
```

You may get a pop-up saying something about the default library location being unaccessible, and asking you if you want to use a local library. If you do get this popup, select 'yes'. `R` should now install the `ggplot2` onto your local system (you should see some output in the console as it does this). Once it's finished enter the following at the console:

```
> library(ggplot2)
```

If this works then congratulations you've installed `ggplot2` and you're ready for the session. If not check online for help, or get in touch with [Jim Leach](mailto:jim.leach@kpmg.co.uk) who will help you too.
