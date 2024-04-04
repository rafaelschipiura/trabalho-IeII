## Slide 1

``` r
n <- 80
p <- 0.12
alpha <- 0.05

lim.fc <- function(p, x, n, qs = 3.841459) {
    (2 * (dbinom(x, n, prob = x/n, log = TRUE) - dbinom(x, n,
        prob = p, log = TRUE))) - qs
}
```

## Slide 2

``` r
estimar_wald <- function(x, n, z = 1.959964) {
    p_hat_w <- x/n
    ep_w <- sqrt(p_hat_w * (1 - p_hat_w)/n)
    return(c(p_hat_w + c(-1, 1) * z * ep_w))
}
estimar_cons <- function(x, n, z = 1.959964) {
    p_hat_w <- x/n
    ep_w <- 1/(2 * sqrt(n))
    return(c(p_hat_w + c(-1, 1) * z * ep_w))
}
estimar_vero <- function(x, n) {
    p_hat_v <- x/n
    return(c(uniroot(lim.fc, c(0, p_hat_v), x, n)$root, uniroot(lim.fc,
        c(p_hat_v, 1), x, n)$root))
}
```

## Slide 3

``` r
cobertura <- function(n_c, p_c) {
    amostra_c <- rbinom(n_c, 1, p_c)
    x_a <- sum(amostra_c)
    n_a <- length(amostra_c)
    IC_wald <- estimar_wald(x_a, n_a)
    result_wald <- IC_wald[1] < p_c & p_c < IC_wald[2]
    IC_cons <- estimar_cons(x_a, n_a)
    result_cons <- IC_cons[1] < p_c & p_c < IC_cons[2]
    IC_vero <- estimar_vero(x_a, n_a)
    result_vero <- IC_vero[1] < p_c & p_c < IC_vero[2]
    IC_jeff <- qbeta(c(0.025, 0.975), x_a + 1/2, (n_a - x_a) +
        1/2)
    result_jeff <- IC_jeff[1] < p_c & p_c < IC_jeff[2]
    IC_prop.test <- prop.test(x_a, n_a)$conf.int
    result_prop.test <- IC_prop.test[1] < p_c & p_c < IC_prop.test[2]
    return(c(result_wald, result_cons, result_vero, result_jeff,
        result_prop.test))
}
```

## Slide 4

``` r
resultado <- data.frame(Cobertura = paste0(100 * rowMeans(replicate(1000,
    cobertura(n, p))), "%"))
rownames(resultado) <- c("Teste de Wald", "Teste Conservador",
    "Teste Verosimilhança", "Teste de Jeffreys", "Teste prop.test")

knitr::kable(resultado)
```

|                      | Cobertura |
| :------------------- | :-------- |
| Teste de Wald        | 92%       |
| Teste Conservador    | 99.9%     |
| Teste Verosimilhança | 93.8%     |
| Teste de Jeffreys    | 93.8%     |
| Teste prop.test      | 96.7%     |
