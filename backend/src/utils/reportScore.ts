export const reportScore = (score: number) => {
  if (score <= 3) {
    return 'Low'
  } else if (score < 5) {
    return 'Moderate'
  } else {
    return 'Important'
  }
}
