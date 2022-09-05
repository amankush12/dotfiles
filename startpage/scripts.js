/* eslint-disable no-undef */
/* eslint-disable no-unused-vars */

/**
 * Search function
 */

const searchInput = document.querySelector("#searchbar > input")
const searchButton = document.querySelector("#searchbar > button")

const lookup = {"YouTube":"https://www.youtube.com"}
const engine = "google"
const engineUrls = {
  deepl: "https://www.deepl.com/translator#-/-/",
  duckduckgo: "https://duckduckgo.com/?q=",
  ecosia: "https://www.ecosia.org/search?q=",
  google: "https://www.google.com/search?q=",
  startpage: "https://www.startpage.com/search?q=",
  youtube: "https://www.youtube.com/results?q=",
}

const isWebUrl = value => {
  try {
    const url = new URL(value)
    return url.protocol === "http:" || url.protocol === "https:"
  } catch {
    return false
  }
}

const getTargetUrl = value => {
  if (isWebUrl(value)) return value
  if (lookup[value]) return lookup[value]
  return engineUrls[engine] + value
}

const search = () => {
  const value = searchInput.value
  const targetUrl = getTargetUrl(value)
  window.open(targetUrl, "_self")
}

searchInput.onkeyup = event => event.key === "Enter" && search()
searchButton.onclick = search

/**
 * inject bookmarks into html
 */

const bookmarks = [{"id":"ojTBBWpONdPFHBWV","label":"Common sites","bookmarks":[{"id":"5sIWQ9yVAGd98O2m","label":"YouTube","url":"https://www.youtube.com"},{"id":"fQKGCi29O3I938Ow","label":"Github","url":"https://github.com"},{"id":"X0Rlu2DEZsvZyTrW","label":"Spotify","url":"https://open.spotify.com"},{"id":"dGiMJA0THTbvgM6n","label":"Udemy","url":"https://www.udemy.com"}]},{"id":"bPNHP2eEpTzPNoOT","label":"Worth reading","bookmarks":[{"id":"kVrg38m5NWOefkEb","label":"Foss Linux","url":"https://www.fosslinux.com"},{"id":"yIHxrA2CG92nuYaA","label":"LinuxHint","url":"https://linuxhint.com"},{"id":"phsTr61XeRgN6vyB","label":"HackerNews","url":"https://thehackernews.com"},{"id":"85Djnvk0W1bltt8e","label":"MDN docs","url":"https://developer.mozilla.org/en-US/docs/Web"}]},{"id":"MHPKWEzRAnKLo2fK","label":"Reddit","bookmarks":[{"id":"5Dur1W9xPE1YHWbf","label":"r/unixporn","url":"https://www.reddit.com/r/unixporn/"},{"id":"B38AUZG8Zc7Ymgyc","label":"r/i3wm","url":"https://www.reddit.com/r/i3wm/"},{"id":"NDZihQpNM2gtZAiL","label":"r/linuxprojects","url":"https://www.reddit.com/r/linuxprojects/"},{"id":"ps1x62SEiRpFUuJf","label":"r/neovim","url":"https://www.reddit.com/r/neovim/"}]},{"id":"6JHyEE5YlcJL22jL","label":"Study","bookmarks":[{"id":"56VqByioKgTZ6kzO","label":"JavaPoint","url":"https://www.javatpoint.com"},{"id":"MFYwLPV6jGeVhvTg","label":"Programiz","url":"https://www.programiz.com"},{"id":"NHX13zkHvw0jY6zl","label":"GeeksForGeeks","url":"https://www.geeksforgeeks.org"},{"id":"TS68406RpSXk1URl","label":"W3School","url":"https://www.w3schools.com"}]},{"id":"DLdbJKNBycvLf1m9","label":"Code Practice","bookmarks":[{"id":"hF0uUmF1Cs07UEG8","label":"LeetCode","url":"https://leetcode.com"},{"id":"U6PrmLKRmVwgEkQK","label":"HackerRank","url":"https://www.hackerrank.com"},{"id":"w8P3usMWZJ5CX9ce","label":"CodePen","url":"https://codepen.io/trending"},{"id":"PfON9HCVv9B151vx","label":"CodeChef","url":"https://www.codechef.com"}]}]

const createGroupContainer = () => {
  const container = document.createElement("div")
  container.className = "bookmark-group"
  return container
}

const createGroupTitle = title => {
  const h2 = document.createElement("h2")
  h2.innerHTML = title
  return h2
}

const createBookmark = ({ label, url }) => {
  const li = document.createElement("li")
  const a = document.createElement("a")
  a.href = url
  a.innerHTML = label
  li.append(a)
  return li
}

const createBookmarkList = bookmarks => {
  const ul = document.createElement("ul")
  bookmarks.map(createBookmark).forEach(li => ul.append(li))
  return ul
}

const createGroup = ({ label, bookmarks }) => {
  const container = createGroupContainer()
  const title = createGroupTitle(label)
  const bookmarkList = createBookmarkList(bookmarks)
  container.append(title)
  container.append(bookmarkList)
  return container
}

const injectBookmarks = () => {
  const bookmarksContainer = document.getElementById("bookmarks")
  bookmarksContainer.append()
  bookmarks.map(createGroup).forEach(group => bookmarksContainer.append(group))
}

injectBookmarks()
