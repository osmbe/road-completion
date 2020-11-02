import getCommits from "../imports/github/commits";

export async function get(req, res) {
  const commits = {
    "be-brussels": await getCommits(
      "data/belgium/brussels/difference/stats.json"
    ),
    "be-flanders": await getCommits(
      "data/belgium/flanders/difference/Wegenregister_SHAPE_20200917/stats.json"
    ),
    "be-wallonia-bra": await getCommits(
      "data/belgium/wallonia/difference/BRA/stats.json"
    ),
    "be-wallonia-hai": await getCommits(
      "data/belgium/wallonia/difference/HAI/stats.json"
    ),
    "be-wallonia-lie": await getCommits(
      "data/belgium/wallonia/difference/LIE/stats.json"
    ),
    "be-wallonia-lux": await getCommits(
      "data/belgium/wallonia/difference/LUX/stats.json"
    ),
    "be-wallonia-nam": await getCommits(
      "data/belgium/wallonia/difference/NAM/stats.json"
    ),
    "xk": await getCommits(
      "data/kosovo/difference/stats.json"
    ),
  };

  res.writeHead(200, {
    "Content-Type": "application/json",
  });

  res.end(JSON.stringify(commits));
}
