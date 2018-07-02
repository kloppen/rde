# Reproducible Data Exchange (rde)
## Overview
This R package allows you to easily share (small) data sets directly in an 
R Notebook or other R code. 

## Usage
If you had a CSV file on your computer called `country_pop.csv` that you used
in your analysis, you'd have to send it along with your code in order for the
recipient to be able to re-run your analysis. However, with the `rde` pacakge,
you can embed the data directly in your code. The code with the embedded data
would look like the following.

```{r}
library(rde)

pop.data <- load_rde_var(
  use.cache = FALSE,
  load.fcn = {
    fname <- system.file("extdata", "country_pop.csv", package = "rde")
    read.csv(fname, stringsAsFactors = FALSE)
  },
  cache = "
    rde1QlpoOTFBWSZTWQy+/kYAAIB3/v//6EJABRg/WlQv797wYkAAAMQiABBAACAAAZGwANk0RTKejU9T
    RoBoGgGjTRoBoGgaGymE0Kp+qemmkDNQ0YmJk0AA0xNADQNPUaA0JRhDTJoANAAAAAAAAEJx2Eja7QBK
    MKPPkRAx63wSAWt31AABs1zauhwHifs5WlltyIyQKAAAZEAZGQYMIZEA6ZAPHVMEB71jSCqdlsiR/eSY
    kzQkRq5RoXgvNNZnB5RSOvKaTGFtc/SXc74AhzqhMEJvdisEGVfo7UYngc0AwGqTvTHx8CBZTzE9OQZZ
    VY8KAhHAhrG4RCeilM0rXKkdpjGqyNgJwAkmnPQOMYrLlQ4YTIv0WyxfYdkd9WSWUsvggC/i7kinChIB
    l9/IwA==
  "
)
```

When the code above is run, `load_rde_var` will first try to run the code in `load.fcn`.
If this suceeds, then tha tdata is returned. Otherwise, it loads the data from the 
encoded string given in the argument `cache`. If you send your code to someone else
and don't send them the data files, when the run the code, they will be getting the
data from the encoded version that is located directly in your code.

The encoded version of the data is easily produced by the function `copy_rde_var`.

Additionally, `load_rde_var` checks that the cahced value matches the result of
`load.fcn` and tells you if there is a difference.


## Installation
This package is not yet on CRAN.

```

# Install the development version from GitHub
# install.packages("devtools")
devtools::install_github("kloppen/rde")
```

## Vignette
For more information about how to use this package, please see the tutorial,
which can be accessed by running one of the following R commands:

```
RShowDoc("rde_tutorial", package = "rde")
# or, alternatively
vignette("rde_tutorial")
```

## Contributing
Contributions to this package are welcome. Please feel free to discuss a
feature that you think should be added in the Issues page on GitHub. Feel
free to submit a Pull Request too. If you submit code, please make sure
that it is tested.

## Bugs
If you discover a bug in this package, please report it by creating an
Issue on GitHub. Please include a 
[reproducible example](https://www.tidyverse.org/help/) and also include
information on which version of R you are running and which version of
each applicable package you have installed.

## License
This package is released under the
[GPL Version 3](https://www.gnu.org/licenses/gpl-3.0.en.html) license.
